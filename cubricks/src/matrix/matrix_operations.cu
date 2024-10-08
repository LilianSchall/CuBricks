#include <iostream>
#include <stdexcept>

#include "matrix/matrix_operations.hh"
#include "memory_checks/cuda_checks.hh"

__global__ void matAddKernel(
                             float *d_A,
                             float *d_B,
                             float *d_C,
                             int width,
                             int height
                            )
{
    int col = blockDim.x * blockIdx.x + threadIdx.x;
    int row = blockDim.y * blockIdx.y + threadIdx.y;

    if (col < width && row < height)
        d_C[row * width + col] = d_A[row * width + col] + d_B[row * width + col];
}

__global__ void matAddKernel(
                             float *d_A,
                             float B,
                             int width,
                             int height
                            )
{
    int col = blockDim.x * blockIdx.x + threadIdx.x;
    int row = blockDim.y * blockIdx.y + threadIdx.y;

    if (col < width && row < height)
        d_A[row * width + col] += B;
}

void computeDims(dim3& dimGrid, dim3& dimBlock, int width, int height)
{
    dimGrid.x = ceil(width / 16.0);
    dimGrid.y = ceil(height / 16.0);

    dimBlock.x = 16.0;
    dimBlock.y = 16.0;
}

Matrix matAdd(const Matrix& A, const Matrix& B)
{
    if (A.width != B.width || A.height != B.height)
        throw std::invalid_argument("Matrix width or height missmatch!");
    std::cout << "A[0] = " << A.data[0] << "\n";

    ERRCHECK(cudaSetDevice(1));
    dim3 dimGrid;
    dim3 dimBlock;

    computeDims(dimGrid, dimBlock, A.width, A.height);

    int size = A.width * A.height * sizeof(float);

    float *d_A;    
    float *d_B;
    float *d_C;

    ERRCHECK(cudaMalloc((void **) &d_A, size));
    ERRCHECK(cudaMalloc((void **) &d_B, size));
    ERRCHECK(cudaMalloc((void **) &d_C, size));
    std::cout << "Finished device malloc\n";

    ERRCHECK(cudaMemcpy(d_A, A.data, size, cudaMemcpyHostToDevice));
    std::cout << "Finished d_A memcpy\n";
    ERRCHECK(cudaMemcpy(d_B, B.data, size, cudaMemcpyHostToDevice));
    std::cout << "Finished d_B memcpy\n";

    std::cout << "Launching kernel matmat\n";
    matAddKernel<<<dimGrid, dimBlock>>>(d_A, d_B, d_C, A.width, A.height);
    ERRCHECK(cudaGetLastError());
    std::cout << "Finished kernel matmat\n";

    float *C = static_cast<float *>(calloc(1, size));


    std::cout << "Begin Memcpy\n";
    ERRCHECK(cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost));
    std::cout << "Finished Memcpy\n";

    ERRCHECK(cudaFree(d_A));
    ERRCHECK(cudaFree(d_B));
    ERRCHECK(cudaFree(d_C));

    cudaDeviceSynchronize();

    return Matrix(A.width, A.height, C);
}

Matrix& matAdd(Matrix& A, const float& B)
{
    ERRCHECK(cudaSetDevice(1));
    dim3 dimGrid;
    dim3 dimBlock;

    computeDims(dimGrid, dimBlock, A.width, A.height);

    int size = A.width * A.height * sizeof(float);

    float *d_A;    

    ERRCHECK(cudaMalloc((void **) &d_A, size));

    ERRCHECK(cudaMemcpy(d_A, A.data, size, cudaMemcpyHostToDevice));

    matAddKernel<<<dimGrid, dimBlock>>>(d_A, B, A.width, A.height);
    ERRCHECK(cudaGetLastError());

    ERRCHECK(cudaMemcpy(A.data, d_A, size, cudaMemcpyDeviceToHost));

    ERRCHECK(cudaFree(d_A));

    cudaDeviceSynchronize();

    return A;
}
