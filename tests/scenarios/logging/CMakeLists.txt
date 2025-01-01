add_unit_test(TEST logging_test
    SOURCES 
        ${CMAKE_CURRENT_SOURCE_DIR}/src/LoggingTests.cpp
    LIBS 
        logger
    )