#include "matrix/matrix.hh"
#include "matrix/matrix_operations.hh"
#include <cstdlib>
#include <iostream>

Matrix::Matrix(int width, int height) : width(width), height(height)
{
    this->data = static_cast<float *>(calloc(width * height, sizeof(float)));
}

Matrix::Matrix(int width, int height, float *data) : width(width), height(height), data(data)
{

}


Matrix& Matrix::operator=(Matrix& other)
{
    if (this == &other)
        return *this;


    this->width = other.width;
    this->height = other.height;
    this->data = other.data;

    other.enableDataCopyFlag();

    return *this;
}

Matrix::Matrix(const Matrix& m)
{
    this->width = m.width;
    this->height = m.height;
    this->data = m.data;
}

Matrix::~Matrix()
{
    if (this->_dataCopied)
        return;

    delete this->data;
}

Matrix& operator+(Matrix& lhs, const float& rhs)
{
    return matAdd(lhs, rhs);
}

Matrix operator+(const Matrix& lhs, const Matrix& rhs)
{
    return matAdd(lhs, rhs);
}

void Matrix::enableDataCopyFlag()
{
    this->_dataCopied = true;
}
