cmake_minimum_required(VERSION 3.22)

add_subdirectory(matrix)

target_sources(${PROJECT_NAME} PRIVATE
    cubricks.cc
)
