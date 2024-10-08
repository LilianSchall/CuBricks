#include "matrix/matrix.hh"
#include <iostream>

int main(void)
{
    Matrix mat1{10000, 10000};
    Matrix mat2{10000, 10000};

    mat1 = mat1 + 10;
    mat2 = mat2 + 1;

    for (int i = 0; i < 10; i++)
    {
        Matrix mat3 = mat1 + mat2;
        mat1 = mat3;
    }

    std::cout<< mat1.data[0] << "\n";

    return 0;
}
