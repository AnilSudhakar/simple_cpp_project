
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

add_executable(app
    src/main.cpp
    )

target_link_libraries(app 
    PRIVATE 
        logger
    )

install(TARGETS logger DESTINATION lib)
install(DIRECTORY include/ DESTINATION include)
