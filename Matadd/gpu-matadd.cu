#include "./common.cpp"

int nrow = 100; 
int ncol = 100; 

__global__ void kernel_matadd( float* matC, float* matA, float* matB, int nrow, int ncol ) {
	int col = blockIdx.x * blockDim.x + threadIdx.x; 
	int row = blockIdx.y * blockDim.y + threadIdx.y; 
	//No for loop

	{
		//Matrix Add concept


	}
}

int main(void) {
	float* matA = nullptr;
	float* matB = nullptr;
	float* matC = nullptr;
	matA = new float[nrow * ncol];
	matB = new float[nrow * ncol];
	matC = new float[nrow * ncol];
	srand( 0 );
	setNormalizedRandomData( matA, nrow * ncol );
	setNormalizedRandomData( matB, nrow * ncol );
	float* dev_matA = nullptr;
	float* dev_matB = nullptr;
	float* dev_matC = nullptr;
	//Memory allocation to GPU



	//Memory Copy CPU to GPU


	dim3 dimBlock(32, 32, 1);
	dim3 dimGrid((ncol + dimBlock.x - 1) / dimBlock.x, (nrow + dimBlock.y - 1) / dimBlock.y, 1);
	ELAPSED_TIME_BEGIN(0);
	kernel_matadd <<< dimGrid, dimBlock>>>( dev_matC, dev_matA, dev_matB, nrow, ncol );
	cudaDeviceSynchronize();
	ELAPSED_TIME_END(0);
	//Memory Copy GPU to CPU

	//Delete GPU's Memory


	CUDA_PRINT_CONFIG_2D(ncol ,nrow);
	printf("matrix size = nrow * ncol = %d * %d\n", nrow, ncol);
	printMat( "matC", matC, nrow, ncol );
	printMat( "matA", matA, nrow, ncol );
	printMat( "matB", matB, nrow, ncol );
	delete[] matA;
	delete[] matB;
	delete[] matC;
	return 0;
}
