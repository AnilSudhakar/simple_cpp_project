import os

from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout
from conan.tools.files import copy

class SimpleCPPConan(ConanFile):
    name = "simple_cpp_project"
    version = "1.0.0"
    description = "A simple end to end C++ project"
    url = "https://github.com/AnilSudhakar/simple_cpp_project.git"
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps"
    default_options = {"gtest/*:shared": False}

    def layout(self):
        cmake_layout(self)

    def requirements(self):
        self.requires("gtest/1.13.0")
    
    def generate(self):
        cmake = CMakeToolchain(self)
        cmake.variables["BUILD_PACKAGE"] = "ON"
        cmake.generate()
        return cmake

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()
    
    def package(self):
        cmake = CMake(self)
        cmake.install()
    
    def package_info(self):
        lib_dir = os.path.join(self.package_folder, "lib")
        include_dir = os.path.join(self.package_folder, "include")
        libs = ["logger"]

        self.cpp_info.libdirs.append(lib_dir)
        self.cpp_info.includedirs.append(include_dir)
        self.cpp_info.libs = libs
    
    def export_sources(self):
        copy(self, "*", src=self.recipe_folder, dst=self.export_sources_folder)
