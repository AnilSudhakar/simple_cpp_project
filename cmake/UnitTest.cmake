enable_testing()

include(GoogleTest)

find_package(GTest REQUIRED)

function(add_unit_test)
    set(options)
    set(oneValueArgs TEST)
    set(multiValueArgs SOURCES LIBS)
    cmake_parse_arguments(UT "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    message(STATUS "Adding unit test: ${UT_TEST}")

    add_executable(${UT_TEST})

    target_sources(${UT_TEST} 
        PRIVATE
             ${UT_SOURCES}
        )

    target_compile_features(${UT_TEST} 
            PRIVATE
                cxx_std_17
        )

    set_target_properties(${UT_TEST} 
            PROPERTIES
                CXX_EXTENSIONS OFF
                CMAKE_CXX_STANDARD_REQUIRED ON
        )

    target_link_libraries(${UT_TEST} 
        PRIVATE 
            gtest::gtest 
            GTest::gtest_main
            ${UT_LIBS}
        )

    target_compile_options(${UT_TEST} 
        PRIVATE 
            -Wall -Wextra -Werror
     )

    gtest_discover_tests(${UT_TEST})
endfunction()