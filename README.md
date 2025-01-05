# simple_cpp_project


This repository contains a simple C++ project demonstrating the setup with the following features:

- Modular code structure with a simple logging library.
- Unit tests for testing functionality.
- Docker setup for development and testing environments.
- Automated build and packaging process using CMake and Conan.
- Continuous Integration setup with GitHub Actions.

---

## Directory Structure

```plaintext
.
├── app                  # Source code of the application
│   ├── include          # Header files
│   │   └── Logger.hpp   # Logging utility header
│   └── src              # Source files
│       └── Logger.cpp   # Logging utility implementation
├── build.sh             # Script to build the project
├── clean_build.sh       # Script to clean the build folder
├── cmake                # CMake helper modules
│   └── UnitTest.cmake   # Unit test configuration
├── conanfile.py         # Conan configuration for dependencies
├── Config.cmake.in      # CMake configuration template
├── development_docker   # Docker setup for development
│   ├── build_docker.sh  # Script to build Docker image
│   ├── Dockerfile       # Docker image definition
│   ├── helper           # Helper tools (e.g., fixuid)
│   ├── push_docker.sh   # Script to push Docker image
│   ├── requirements.txt # Development requirements
│   └── toolchain_catalog.apt-get.packages # Toolchain dependencies
├── package.sh           # Script to package the project
├── run_docker.sh        # Script to run the project in Docker
├── run_unit_tests.sh    # Script to run unit tests
├── test_package         # Test package setup
├── tests                # Unit tests
├── README.md            # Project documentation
└── upload_package.sh    # upload conan package to Jfrog artifactory
```

---

## Getting Started

### Prerequisites

- **CMake** (>= 3.16)
- **Conan** (>= 1.39)
- **Docker**

### Build and Run

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/AnilSudhakar/simple_cpp_project.git
   cd simple_cpp_project
   ```

2. **Build the Project:**

   ```bash
   ./build.sh
   ```

3. **Run Unit Tests:**
    The unit-tests can be created as targets with all the necessary target set-up using the CMake function `add_unit_test()` which finds the gtest libraries and links against the test executable.
   ```bash
   ./run_unit_tests.sh
   ```

4. **Package the Library:**

   ```bash
   ./package.sh
   ```

5. **Upload the conan package:**

   ```bash
   ./upload_package.sh
   ```
---

Once the package is pushed into the artifactory then it can be consumed as shown in this [sample_application](https://github.com/AnilSudhakar/sample_application).

## Docker Setup

This project includes a Docker-based development setup. To use Docker:

1. **Pre-requiste install docker:**

   ```bash
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
   ```

2. **Build the Docker Image:**

   ```bash
   cd development_docker
   ./build_docker.sh
   ```

3. **Run the Docker Container:**

   ```bash
   ./run_docker.sh
   ```

4. **Push docker image to Jfrog artifactory(optional)**

   ```bash
   ./push_docker.sh
   ```

---

## Continuous Integration

This project uses GitHub Actions for CI. The pipeline performs the following:

1. Build the project using CMake.
2. Run unit tests.
3. Package the library.

---

## Contributing

Feel free to submit issues or pull requests to improve this project. Contributions are welcome!

### How to Contribute

1. Fork the repository.
2. Create a new branch for your feature.
3. Make your changes and write tests if applicable.
4. Submit a pull request.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Acknowledgments

- Thanks to the contributors of CMake, Conan, and Docker for making software development simpler and more efficient.
