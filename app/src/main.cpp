#include "Logger.hpp"

#include <cstdlib>

int main() {
    logging::Logger& logger = logging::Logger::getInstance();
    logger.setLogLevel(logging::LogLevel::INFO);
    logger.setOutputFile("log.txt");

    logger.log(logging::LogLevel::INFO, "Simple log message");

  return EXIT_SUCCESS;
}
