#pragma once

#include <string>
#include <fstream>

namespace logging {

enum class LogLevel { INFO, WARN, ERROR, DEBUG };

class Logger {
public:
    static Logger& getInstance();

    void setLogLevel(LogLevel level);
    LogLevel getLogLevel() const;

    bool isLogLevelEnabled(LogLevel level) const;
    
    void setOutputFile(const std::string& filename);

    void log(LogLevel level, const std::string& message);

private:
    Logger();
    ~Logger();
    
    LogLevel _currentLevel;
    std::ofstream _logFile;

    std::string logLevelToString(LogLevel level) const;
};

} // namespace logging
