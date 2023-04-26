#include "./common.cpp"

int nrow = 3; 
int ncol = 3; 

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
	ELAPSED_TIME_BEGIN(0);
	for (int row = 0; row < nrow; ++row) {
		for (int col = 0; col < ncol; ++col) {
			int i = row * ncol + col; 
			matC[i] = matA[i] + matB[i];
		}
	}
	ELAPSED_TIME_END(0);
	printf("matrix size = nrow * ncol = %d * %d\n", nrow, ncol);
	printMats( "matC", matC, nrow, ncol );
	printMats( "matA", matA, nrow, ncol );
	printMats( "matB", matB, nrow, ncol );
	delete[] matA;
	delete[] matB;
	delete[] matC;
	return 0;
}
