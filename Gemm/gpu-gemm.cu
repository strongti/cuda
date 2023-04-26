#include "./common.cpp"


float alpha = 0.5f;
float beta = -100.0f;
int matsize = 100; 


__global__ void kernelGEMM( float* C, float* A, float* B, int matsize, float alpha, float beta ) {
	//Matrix multiply concept with Matrix add



	{








	}
}

int main(void) {
	float* matA = nullptr;
	float* matB = nullptr;
	float* matC = nullptr;
	matA = new float[matsize * matsize];
	matB = new float[matsize * matsize];
	matC = new float[matsize * matsize];
	printMat( "Before_matC", matC, matsize, matsize );
	srand( 0 );
	setNormalizedRandomData( matA, matsize * matsize );
	setNormalizedRandomData( matB, matsize * matsize );
	float* dev_matA = nullptr;
	float* dev_matB = nullptr;
	float* dev_matC = nullptr;
	//Memory allocation to GPU



	//Memory Copy CPU to GPU



	dim3 dimBlock(32, 32, 1);
	dim3 dimGrid((matsize + dimBlock.x - 1) / dimBlock.x, (matsize + dimBlock.y - 1) / dimBlock.y, 1);
	ELAPSED_TIME_BEGIN(0);
	kernelGEMM <<< dimGrid, dimBlock>>>(dev_matC, dev_matA, dev_matB, matsize, alpha, beta );
	cudaDeviceSynchronize();
	ELAPSED_TIME_END(0);
	//Memory Copy GPU to CPU

	//Delete GPU's Memory



	printf("matrix size = matsize * matsize = %d * %d\n", matsize, matsize);
	printMat( "matA", matA, matsize, matsize );
	printMat( "matB", matB, matsize, matsize );
	printMat( "After_matC", matC, matsize, matsize );
	delete[] matA;
	delete[] matB;
	delete[] matC;
	return 0;
}
