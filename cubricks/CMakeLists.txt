cmake_minimum_required(VERSION 3.22)

project(cubricks LANGUAGES CXX CUDA)

add_executable(cubricks)
add_subdirectory(src/)

set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
set_target_properties(${PROJECT_NAME} PROPERTIES
    CXX_STANDARD 20
)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")

# target_compile_options(${PROJECT_NAME} PRIVATE
#              "$<$<COMPILE_LANGUAGE:CUDA>:SHELL:--compiler-options -Werror,-Wall>"
#              "$<$<COMPILE_LANGUAGE:CXX>:-Werror; -Wextra -Wall>")

find_package(CUDAToolkit REQUIRED)

target_include_directories(${PROJECT_NAME} PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>  # Apply to both CXX and CUDA
    $<TARGET_PROPERTY:CUDAToolkit_INCLUDE_DIRS>
)

# Alternatively, ensure that CUDA and CXX explicitly get the include directories
target_include_directories(${PROJECT_NAME} PRIVATE
    $<$<COMPILE_LANGUAGE:CXX>:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<$<COMPILE_LANGUAGE:CUDA>:${CMAKE_CURRENT_SOURCE_DIR}/src>
)

set_target_properties(${PROJECT_NAME} PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
set_target_properties(${PROJECT_NAME} PROPERTIES POSITION_INDEPENDENT_CODE ON)
