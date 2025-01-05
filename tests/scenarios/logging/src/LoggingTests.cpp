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

TEST_F(LoggerTest, SingletonInstance) {
    Logger& anotherInstance = Logger::getInstance();
    EXPECT_EQ(&logger, &anotherInstance);
}

TEST_F(LoggerTest, DefaultLogLevel) {
    EXPECT_TRUE(logger.isLogLevelEnabled(LogLevel::INFO));
    EXPECT_FALSE(logger.isLogLevelEnabled(LogLevel::DEBUG));
}

TEST_F(LoggerTest, SetLogLevel) {
    logger.setLogLevel(LogLevel::ERROR);
    EXPECT_FALSE(logger.isLogLevelEnabled(LogLevel::INFO));
    EXPECT_TRUE(logger.isLogLevelEnabled(LogLevel::ERROR));
    logger.setLogLevel(LogLevel::DEBUG);
    EXPECT_TRUE(logger.isLogLevelEnabled(LogLevel::DEBUG));
}

TEST_F(LoggerTest, LogToConsole) {
    testing::internal::CaptureStdout();
    logger.setLogLevel(LogLevel::INFO);
    logger.log(LogLevel::INFO, "Test console logging");
    std::string output = testing::internal::GetCapturedStdout();

    EXPECT_NE(output.find("[INFO]"), std::string::npos);
    EXPECT_NE(output.find("Test console logging"), std::string::npos);
}

TEST_F(LoggerTest, LogToFile) {
    logger.setOutputFile("test_log.txt");
    logger.setLogLevel(LogLevel::INFO);
    logger.log(LogLevel::INFO, "Test file logging");

    std::string content = readFile("test_log.txt");
    EXPECT_NE(content.find("[DEBUG]"), std::string::npos);
    EXPECT_NE(content.find("Test file logging"), std::string::npos);
}

TEST_F(LoggerTest, LogLevelFiltering) {
    logger.setOutputFile("test_log.txt");
    logger.setLogLevel(LogLevel::WARN);

    logger.log(LogLevel::INFO, "This should not be logged");
    logger.log(LogLevel::WARN, "This should be logged");

    std::string content = readFile("test_log.txt");
    EXPECT_EQ(content.find("This should not be logged"), std::string::npos);
    EXPECT_NE(content.find("This should be logged"), std::string::npos);
}

TEST_F(LoggerTest, LogFileOverwrite) {
    logger.setOutputFile("test_log.txt");
    logger.log(LogLevel::INFO, "First log message");

    logger.setOutputFile("test_log.txt");
    logger.log(LogLevel::INFO, "Second log message");

    std::string content = readFile("test_log.txt");
    EXPECT_NE(content.find("First log message"), std::string::npos);
    EXPECT_NE(content.find("Second log message"), std::string::npos);
}
