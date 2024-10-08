cmake_minimum_required(VERSION 3.22)

project(cubricks LANGUAGES CXX CUDA)

add_executable(cubricks)
add_subdirectory(src/)

set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
set_target_properties(${PROJECT_NAME} PROPERTIES
    CXX_STANDARD 20
)

# target_compile_options(${PROJECT_NAME} PRIVATE
#              "$<$<COMPILE_LANGUAGE:CUDA>:SHELL:--compiler-options -Werror,-Wall>"
#              "$<$<COMPILE_LANGUAGE:CXX>:-Werror; -Wextra -Wall>")

target_include_directories(${PROJECT_NAME} PUBLIC src/)

find_package(CUDAToolkit REQUIRED)

set_target_properties(${PROJECT_NAME} PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
