#include "./common.cpp"

int matsize = 100;

__global__ void kernelMatMul( float* C, float* A, float* B, int matsize ) {
	int gy = blockIdx.y * blockDim.y + threadIdx.y; 
	int gx = blockIdx.x * blockDim.x + threadIdx.x; 
	if (gy < matsize && gx < matsize)
	{
		float sum = 0.0f;
		for (int k = 0; k < matsize; ++k) {
			int idxA = gy * matsize + k;
			int idxB = k * matsize + gx;
			sum += A[idxA] * B[idxB];
		}
		int idxC = gy * matsize + gx;
		C[idxC] = sum;
	}
}
int main(void) {
	float* matA = nullptr;
	float* matB = nullptr;
	float* matC = nullptr;
	matA = new float[matsize * matsize];
	matB = new float[matsize * matsize];
	matC = new float[matsize * matsize];
	srand( 0 );
	setNormalizedRandomData( matA, matsize * matsize );
	setNormalizedRandomData( matB, matsize * matsize );
	float* dev_matA = nullptr;
	float* dev_matB = nullptr;
	float* dev_matC = nullptr;
	cudaMalloc( (void**)&dev_matA, matsize *  matsize * sizeof(float) );
	cudaMalloc( (void**)&dev_matB,  matsize *  matsize * sizeof(float) );
	cudaMalloc( (void**)&dev_matC,  matsize *  matsize * sizeof(float));
	cudaMemcpy( dev_matA, matA,  matsize * matsize * sizeof(float),  cudaMemcpyHostToDevice);
	cudaMemcpy( dev_matB, matB,  matsize * matsize * sizeof(float), cudaMemcpyHostToDevice);
	dim3 dimBlock(32, 32, 1);
	dim3 dimGrid((matsize + dimBlock.x - 1) / dimBlock.x, (matsize + dimBlock.y - 1) / dimBlock.y, 1);
	ELAPSED_TIME_BEGIN(0);
	kernelMatMul <<< dimGrid, dimBlock>>>( dev_matC, dev_matA, dev_matB, matsize);
	cudaDeviceSynchronize();
	ELAPSED_TIME_END(0);
	cudaMemcpy( matC, dev_matC, matsize *matsize * sizeof(float), cudaMemcpyDeviceToHost);
	cudaFree( dev_matA );
	cudaFree( dev_matB );
	cudaFree( dev_matC );
	printf("matrix size = matsize * matsize = %d * %d\n", matsize, matsize);
	printMat( "matC", matC, matsize, matsize );
	printMat( "matA", matA, matsize, matsize );
	printMat( "matB", matB, matsize, matsize );
	delete[] matA;
	delete[] matB;
	delete[] matC;

	return 0;
}
