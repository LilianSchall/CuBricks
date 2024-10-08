#ifndef MATRIX_HH
#define MATRIX_HH

#include <deque>
class Matrix
{
public:
    explicit Matrix(int width, int height);
    explicit Matrix(int width, int height, float *data);
    explicit Matrix(const Matrix& m);
    ~Matrix();
    Matrix& operator=(Matrix& other);
    friend Matrix& operator+(Matrix& lhs, const float& rhs);
    friend Matrix operator+(const Matrix& lhs, const Matrix& rhs);

private:
    void enableDataCopyFlag();

public:
    int width;
    int height;
    float *data = nullptr;

private:
    bool _dataCopied = false;
};

#endif //!MATRIX_HH
