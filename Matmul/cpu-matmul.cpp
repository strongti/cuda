#include "./common.cpp"

int matsize = 100;

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
	ELAPSED_TIME_BEGIN(0);
	for (int y = 0; y < matsize; ++y) {
		for (int x = 0; x < matsize; ++x) {
			int indC = y * matsize + x;
			float ans = 0.0f;
			for (int k = 0; k < matsize; ++k) {
				int indA = y * matsize + k; 
				int indB = k * matsize + x;
				ans += matA[indA] * matB[indB];
			}
			matC[indC] = ans;
		}
	}
	ELAPSED_TIME_END(0);
	printf("matrix size = matsize * matsize = %d * %d\n", matsize, matsize);
	printMat( "matC", matC, matsize, matsize );
	printMat( "matA", matA, matsize, matsize );
	printMat( "matB", matB, matsize, matsize );
	delete[] matA;
	delete[] matB;
	delete[] matC;
	return 0;
}

