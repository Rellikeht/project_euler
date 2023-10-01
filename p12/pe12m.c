#include <stdio.h>
#include <math.h>

int factorCount (int n)
{
	int count = 1;
	int candidate,tmpCount;
	while (n % 2 == 0) {
		count++;
		n /= 2;
	}
	for (candidate = 3; candidate < n && candidate * candidate < n; candidate += 2)
		if (n % candidate == 0) {
			tmpCount = 1;
			do {
				tmpCount++;
				n /= candidate;
			} while (n % candidate == 0);
			count*=tmpCount;
		}
	if (n > 1)
		count *= 2;
	return count;
}

int main ()
{
	int triangle = 1;
	int index = 1;
	int max;
	scanf("%i", &max);

	while (factorCount (triangle) <= max)
	{
		index++;
		triangle += index;
	}
	printf ("%d\n", triangle);
}

