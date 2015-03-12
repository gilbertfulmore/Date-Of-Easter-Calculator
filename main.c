/**
 * Date of Easter Calculator
 * Course:      Computer Science 221
 * Institution: Okanagan College
 * Author:      Gilbert Fulmore
 * Date:        2015-02-28
 */
#include <stdlib.h>

int main() {
	
	int c;	//century
	int y;	//year
	int m;	//month
	int d;	//day

	int g;	//golden number
	int x;	//number of dropped leap years
	int z;	//synchronize easter with moon orbit
	int e;	//epact
	int n;	//find full moon

	printf("Enter Year: ");
	scanf("%d", &y);
		
	//find golden number
	g = (y % 19) + 1;
	
	//find century
	c = (y / 100) + 1;
	
	if (y % 100 != 0) {
		x = (3 * c / 4) - 12;
		z = ((8 * c + 5) / 25) - 5;
	}
	
	//find sunday
	d = (5 * y / 4) - x - 10;
	
	//find the "epact" E
	e = (11 * g + 20 + z - x) % 30;
	
	if (e == 25 && g > 11 || e == 24)
		++e;
	
	//find full moon
	n = 44 - e;

	if (n < 21)
		n += 30;

	//advance to sunday
	n = n + 7 - ((d + n) % 7);

	//get month
	if (n > 31) {
		m = 4;
		d = n-31;
	} else {
		m = 3;
		d = n;
	}

	printf("Easter date: %d-%d-%d\n", y, m, d);
	return 0;
}