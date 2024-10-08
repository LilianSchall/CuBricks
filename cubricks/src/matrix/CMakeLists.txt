cmake_minimum_required(VERSION 3.22)

target_sources(${PROJECT_NAME} PRIVATE
    matrix.cc
    matrix_operations.cu
)
