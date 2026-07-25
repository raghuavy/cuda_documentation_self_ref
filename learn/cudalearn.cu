/*
To run the code:

nvcc -arch=sm_120 .\cudalearn.cu -o .\cudalearn.exe
>> .\cudalearn.exe
*/

#include <cuda_runtime.h>
#include <cstdio>
#include <iostream>

using namespace std;

__global__ void vectAdd(float* A, 
                        float* B,
                        float* C){
    int workIndex = blockIdx.x * blockDim.x + threadIdx.x;
    C[workIndex] = A[workIndex] + B[workIndex]; 

}
int main(){
    float a = 1.0f;float b = 2.0f;float c = 0.0f;
    float *d_a, *d_b, *d_c;
    cudaMalloc(&d_a, sizeof(float));
    cudaMalloc(&d_b, sizeof(float));
    cudaMalloc(&d_c, sizeof(float));

    cudaMemcpy(d_a,&a,sizeof(float),cudaMemcpyHostToDevice);
    cudaMemcpy(d_b,&b,sizeof(float),cudaMemcpyHostToDevice);
    
    vectAdd<<<1,1>>>(d_a,d_b,d_c);//init -- c = a + b
    cudaMemcpy(&c, d_c, sizeof(float),cudaMemcpyDeviceToHost);
    cout << "the answer: " << c << endl;
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    //vectAdd<<<Grid Dimensions, Thread Block Dimensions>>>
    
    //
    //vectAdd<<<1,256>>>(A,B,C);
    
    
    /*
    Theres a limit to the number of thread per block, since all
    threads of a block reside on the same streaming multiprocessor(SM)
    and must share the resource of the SM

    thread block --> upto 1024 threads

    Kernal launcges are async: they disregard the computation on the GPU
    and the status of the host code some form of sync should be used in order to 
    determine that the kernel has complete 
    */

    //use dim3 when using 2 or 3 dimensional thread blocks
    //dim3 grid(16,16);
    //dim3 block(8,8);
    //MatAdd<<<grid,block>>> (A,B,C);

    /*
    threadIdx - gives the index of thread within the thread block 
    blockDim - gives the dimension of the threadblock which was specified
    in the congfiguration of the kernal launch
    blockIdx - give sthe index of a thread block within the grid.
    gridDim- gives teh dimensions of the block which was specified
    in the execution configuration when the kernel was launched
    */
   //each of these is a 3 component vector with a .x,.y and a .z
    return 0;
}