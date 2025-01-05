#include "Logger.hpp"

int main() {
    logging::Logger& logger = logging::Logger::getInstance();
    logger.setLogLevel(logging::LogLevel::INFO);
    logger.setOutputFile("log.txt");
    logger.log(logging::LogLevel::INFO, "Hello, World!");
    logger.setLogLevel(logging::LogLevel::DEBUG);
    logger.log(logging::LogLevel::DEBUG, "This is a debug message.");
    logger.setLogLevel(logging::LogLevel::ERROR);
    logger.log(logging::LogLevel::ERROR, "This is an error message.");
    return 0;
}
