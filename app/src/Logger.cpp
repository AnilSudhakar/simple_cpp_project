#include "Logger.hpp"

#include <iostream>
#include <ctime>
#include <sstream>
#include <iomanip> 

namespace logging {

Logger& Logger::getInstance() {
    static Logger instance;
    return instance;
}

Logger::Logger() : _currentLevel(LogLevel::INFO) {}

Logger::~Logger() {
    if (_logFile.is_open()) {
        _logFile.close();
    }
}

void Logger::setLogLevel(LogLevel level) {
    _currentLevel = level;
}

void Logger::setOutputFile(const std::string& filename) {
    if (_logFile.is_open()) {
        _logFile.close();
    }
    _logFile.open(filename, std::ios::out | std::ios::app);
}

void Logger::log(LogLevel level, const std::string& message) {
    if (!isLogLevelEnabled(level)) {
        return;
    } 

    auto t = std::time(nullptr);
    auto tm = *std::localtime(&t);

    std::ostringstream oss;
    oss << "[" << logLevelToString(level) << "] "
        << std::put_time(&tm, "%Y-%m-%d %H:%M:%S") << ": "
        << message << "\n";

    if (_logFile.is_open()) {
        _logFile << oss.str();
    } else {
        std::cout << oss.str();
    }
}

bool Logger::isLogLevelEnabled(LogLevel level) const {
    return level >= _currentLevel;
}

std::string Logger::logLevelToString(LogLevel level) const {
    switch (level) {
    case LogLevel::INFO: return "INFO";
    case LogLevel::WARN: return "WARN";
    case LogLevel::ERROR: return "ERROR";
    case LogLevel::DEBUG: return "DEBUG";
    default: return "UNKNOWN";
    }
}

} // namespace logging
