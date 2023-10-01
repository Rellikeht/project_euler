#include <stdio.h>

#define INP_ARR_W 20
#define INP_ARR_H 20

int main (int argc, char ** argv) {
	unsigned char inp_arr[INP_ARR_H][INP_ARR_W];
	unsigned int w_arr[INP_ARR_H][INP_ARR_W-1];
	unsigned int h_arr[INP_ARR_H-1][INP_ARR_W];
	unsigned int d1_arr[INP_ARR_H-1][INP_ARR_W-1];
	unsigned int d2_arr[INP_ARR_H-1][INP_ARR_W-1];
	unsigned int tv, biggest = 0;
	unsigned short i, j;

	for (i=0;i<INP_ARR_H;i++) {
		for (j=0;j<INP_ARR_W;j++) {
			scanf ("%u", &inp_arr[i][j]);

			if (j > 0) {
				w_arr[i][j-1] = inp_arr[i][j] * inp_arr[i][j-1];
				if (i < (INP_ARR_H-1)) {
					d1_arr[i][j-1] = inp_arr[i][j] * inp_arr[i-1][j-1];
				}
			}
			if (i > 0) {
				h_arr[i-1][j] = inp_arr[i][j] * inp_arr[i-1][j];
				if (j < (INP_ARR_W-1)) {
					d2_arr[i-1][j] = inp_arr[i][j] * inp_arr[i-1][j+1];
				}
			}
		}
	}

	for (i=0;i<INP_ARR_H-3;i++) {
		for (j=0;j<INP_ARR_W-3;j++) {
			tv = w_arr[i][j] * w_arr[i][j+2];
			if (tv > biggest) {
//				printf ("1: %u\n", tv);
				biggest = tv;
			}

			tv = h_arr[i][j] * h_arr[i+2][j];
			if (tv > biggest) {
//				printf ("2: %u\n", tv);
				biggest = tv;
			}

			tv = d1_arr[i][j] * d1_arr[i+2][j+2];
			if (tv > biggest) {
//				printf ("3: %u\n", tv);
				biggest = tv;
			}

			tv = d2_arr[i][j+2] * d2_arr[i+2][j];
			if (tv > biggest) {
//				printf ("4: %u\n", tv);
				biggest = tv;
			}
		}
	}

	printf ("%u\n", biggest);

	return 0;
}
