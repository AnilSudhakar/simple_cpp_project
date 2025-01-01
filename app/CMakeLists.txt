
add_library(logger SHARED)

target_sources(logger 
    PUBLIC 
        include/Logger.hpp
        src/Logger.cpp
    )
target_include_directories(logger 
    PUBLIC 
        include
    )

target_compile_options(logger
    PRIVATE
    )

target_compile_features(logger
    PRIVATE
        cxx_std_17
    )

install(TARGETS logger DESTINATION lib)
install(DIRECTORY include/ DESTINATION include)
