#include <cuda_runtime.h>
#include <cstdio>
using namespace std;
__global__ void vectAdd(float* A, 
                        float* B,
                        float* C){

}
int main(){
    //vectAdd<<<Grid Dimensions, Thread Block Dimensions>>>
    vectAdd<<<1,256>>>(A,B,C);
    return 0;
}