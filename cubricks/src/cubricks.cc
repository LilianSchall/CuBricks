#include "matrix/matrix.hh"
#include <iostream>

int main(void)
{
    Matrix mat1{10000, 10000};
    Matrix mat2{10000, 10000};

    std::cout << "Instantiated two matrices of size 10,10\n";

    mat1 = mat1 + 10;
    std::cout << "Added 10 to mat1\n";
    mat2 = mat2 + 1;


    for (int i = 0; i < 10; i++)
    {
        std::cout << "Mat1[0] = " << mat1.data[0] << "\n";
        std::cout << "Launching Addition\n";
        Matrix mat3 = mat1 + mat2;
        std::cout << "Mat3[0] = " << mat3.data[0] << "\n";
        mat1 = mat3;
        std::cout << "Finished Addition\n";
    }

    std::cout<< mat1.data[0] << "\n";

    return 0;
}
