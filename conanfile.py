from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout

class SimpleCPPConan(ConanFile):
    name = "simple_cpp_project"
    version = "0.0.1"
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps", "CMakeToolchain"
    default_options = {"gtest:shared": False}

    def layout(self):
        cmake_layout(self)

    def requirements(self):
        self.requires("gtest/1.13.0")

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def test(self):
        if not self.conf.get("tools.build:skip_test", default=False):
            cmake = CMake(self)
            cmake.test()
