#include "Logger.hpp"

#include <gtest/gtest.h>

#include <sstream>
#include <cstdio>

using namespace logging;
using namespace testing;

class LoggerTest : public Test {
protected:
    Logger& logger = Logger::getInstance();

    std::string readFile(const std::string& filename) {
        std::ifstream file(filename);
        std::stringstream buffer;
        buffer << file.rdbuf();
        return buffer.str();
    }

    void TearDown() override {
        std::remove("test_log.txt");
    }
};

TEST_F(LoggerTest, singletonInstance) {
    Logger& anotherInstance = Logger::getInstance();
    EXPECT_EQ(&logger, &anotherInstance);
}

TEST_F(LoggerTest, checkLogLevel) {
    logger.setLogLevel(LogLevel::ERROR);
    auto logLevel = logger.getLogLevel();
    EXPECT_EQ(logLevel, LogLevel::ERROR);

    logger.setLogLevel(LogLevel::DEBUG);
    logLevel = logger.getLogLevel();
    EXPECT_EQ(logLevel, LogLevel::DEBUG);
}

TEST_F(LoggerTest, logToConsole) {
    testing::internal::CaptureStdout();
    logger.setLogLevel(LogLevel::INFO);
    logger.log(LogLevel::INFO, "Test console logging");
    std::string output = testing::internal::GetCapturedStdout();

    EXPECT_NE(output.find("[INFO]"), std::string::npos);
    EXPECT_NE(output.find("Test console logging"), std::string::npos);
}

TEST_F(LoggerTest, logToFile) {
    logger.setOutputFile("test_log.txt");
    logger.setLogLevel(LogLevel::INFO);
    logger.log(LogLevel::INFO, "Test file logging");

    std::string content = readFile("test_log.txt");
    EXPECT_NE(content.find("[INFO]"), std::string::npos);
    EXPECT_NE(content.find("Test file logging"), std::string::npos);
}

TEST_F(LoggerTest, logLevelFiltering) {
    logger.setOutputFile("test_log.txt");
    logger.setLogLevel(LogLevel::WARN);

    logger.log(LogLevel::INFO, "This should not be logged");
    logger.log(LogLevel::WARN, "This should be logged");

    std::string content = readFile("test_log.txt");
    EXPECT_NE(content.find("This should not be logged"), std::string::npos);
    EXPECT_NE(content.find("This should be logged"), std::string::npos);
}

TEST_F(LoggerTest, logFileOverwrite) {
    logger.setOutputFile("test_log.txt");
    logger.log(LogLevel::INFO, "First log message");

    logger.setOutputFile("test_log.txt");
    logger.log(LogLevel::INFO, "Second log message");

    std::string content = readFile("test_log.txt");
    EXPECT_NE(content.find("First log message"), std::string::npos);
    EXPECT_NE(content.find("Second log message"), std::string::npos);
}
