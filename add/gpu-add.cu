#include "./common.cpp"

__global__ void add_kernel( int* c, int* a, int* b ) {
	int i = threadIdx.x;
	c[i] = a[i] + b[i];
}

int main(void) {
	int SIZE = 5;
	int a[SIZE] = { 1, 2, 3, 4, 5 };
	int b[SIZE] = { 10, 20, 30, 40, 50 };
	int c[SIZE] = { 0 };
	int* dev_a = nullptr;
	int* dev_b = nullptr;
	int* dev_c = nullptr;
	cudaMalloc( (void**)&dev_a, SIZE * sizeof(int) );
	cudaMalloc( (void**)&dev_b, SIZE * sizeof(int) );
	cudaMalloc( (void**)&dev_c, SIZE * sizeof(int) );
	cudaMemcpy( dev_a, a, SIZE * sizeof(int), cudaMemcpyHostToDevice );
	cudaMemcpy( dev_b, b, SIZE * sizeof(int), cudaMemcpyHostToDevice );
	ELAPSED_TIME_BEGIN(0);
	add_kernel<<<1,SIZE>>>( dev_c, dev_a, dev_b );
	cudaDeviceSynchronize();
	ELAPSED_TIME_END(0);
	cudaMemcpy( c, dev_c, SIZE * sizeof(int), cudaMemcpyDeviceToHost );
	cudaFree(dev_a );
	cudaFree(dev_b );
	cudaFree(dev_c );
	printf("{%d,%d,%d,%d,%d} + {%d,%d,%d,%d,%d} = {%d,%d,%d,%d,%d}\n",
	       a[0], a[1], a[2], a[3], a[4],
	       b[0], b[1], b[2], b[3], b[4],
	       c[0], c[1], c[2], c[3], c[4]);
	return 0;
}

