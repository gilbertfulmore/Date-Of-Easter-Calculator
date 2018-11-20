/**
 * Date of Easter Calculator
 * Course:      Computer Science 211
 * Institution: Okanagan College
 * Author:      Gilbert Fulmore
 * Date:        2015-03-02
 * Platform:	Solaris Sparc
 */
define(c_r, l0)    !century
define(y_r, l1)    !year
define(m_r, l2)    !month
define(d_r, l3)    !day
define(g_r, l4)    !golden number
define(x_r, l5)    !number of leap years
define(z_r, l6)    !synchronize easter with moon orbit
define(e_r, l7)    !epact
define(n_r, g2)    !find full moon

	.global main
main:
	save   %sp, -96, %sp
	mov    1951, %y_r		!#enter year
		     		 	!#find golden number
	mov    %y_r, %o0		!g = (y % 19) + 1;
	call   .rem
	mov    19, %o1
	add    %o0, 1, %g_r
					!#find century
	mov    %y_r, %o0		!c = (y / 100) + 1;
	call   .div
	mov    100, %o1
	add    %o0, 1, %c_r

	mov    %y_r, %o0		!if (y % 100 != 0) {
	call   .rem
	mov    100, %o1
 	cmp    %o0, %g0
	be     endIfA
	mov    3, %o0			    !x = (3 * c / 4) - 12;
	
	call   .mul
    	mov    %c_r, %o1
    	call   .div
    	mov    4, %o1
    	sub    %o0, 12, %x_r
	
	mov    8, %o0			    !z = ((8 * c + 5) / 25) - 5;
	call   .mul
	mov    %c_r, %o1
	add    %o0, 5, %o0
	call   .div
	mov    25, %o1
    	sub    %o0, 5, %z_r
endIfA:				        !}
	
					!#find sunday
	mov    5, %o0			!d = (5 * y / 4) - x - 10;
	call   .mul
	mov    %y_r, %o1
	call   .div
	mov    4, %o1
	sub    %o0, %x_r, %o0
	sub    %o0, 10, %d_r
					!#find the epact
	mov    11, %o0 			!e = (11 * g + 20 + z - x) % 30;
	call   .mul
	mov    %g_r, %o1
	add    %o0, 20, %o0
	add    %o0, %z_r, %o0
	sub    %o0, %x_r, %o0
	call   .rem
	mov    30, %o1
	mov    %o0, %e_r
					!if (e == 25 && g > 11 || e == 24)
	subcc  %e_r, 25, %o0		!o0 = (e == 25)				
	subcc  %g_r, %l1, %o1		!o1 = (g > l1)
	andcc  %o0, %o1, %o0		!o0 = (o0 && o1)
	subcc  %e_r, 24, %o1		!o1 = (e == 24)
	or     %o0, %o1, %o0		!o0 = (o0 || o1)
	cmp    %o0, %g0
	be     endIfB
	mov    44, %o0			!post endIfB: (find full moon)

	add    %e_r, 1, %e_r   	        	!++e;	
				
endIfB:
	
	sub    %o0, %e_r, %n_r		!n = 44 - e;

	cmp    %n_r, 21			!if (n < 21)
	bge    endIfC
	nop

	add    %n_r, 30, %n_r			!n += 30;
endIfC:
					!//advance to sunday
	add    %d_r, %n_r, %o0		!n = n + 7 - ((d + n) % 7);
	call   .rem
	mov    7, %o1
	add    %n_r, 7, %n_r
	sub    %n_r, %o0, %n_r
					!//get month
	cmp    %n_r, 31			!if (n > 31) {
	ble,a  else
	mov    3, %m_r				!m = 3;
	
	mov    4, %m_r			    	!m = 4;
	sub    %n_r, 31, %d_r			!d = n-31;
	ba     endIfD
	mov    1, %g1
else:					!} else {
	mov    %n_r, %d_r            		!d = n;
	mov    1, %g1			 
endIfD:					!}
	ta     0
