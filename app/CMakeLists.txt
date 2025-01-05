
add_library(logger SHARED)

target_sources(logger 
    PRIVATE 
        ${CMAKE_CURRENT_SOURCE_DIR}/include/Logger.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/Logger.cpp
    )

target_include_directories(logger 
    PUBLIC 
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    )

target_compile_options(logger
    PRIVATE
        -Wall -Wextra -Werror
    )

set_target_properties(logger
    PROPERTIES
        CXX_EXTENSIONS OFF
        CMAKE_CXX_STANDARD_REQUIRED ON
    )

target_compile_features(logger
    PRIVATE
        cxx_std_17
    )

install(
    TARGETS
        logger
    EXPORT
        ${PROJECT_NAME}-EXPORT_GROUP
    LIBRARY
    DESTINATION
        ${CMAKE_INSTALL_LIBDIR}
)
install(
    DIRECTORY
        include/
    DESTINATION
        ${CMAKE_INSTALL_INCLUDEDIR}
)
