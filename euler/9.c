/*  
    Euler Project
    #9

    Problem:
    A Pythagorean triplet is a set of three natural numbers, a  b  c, for which,

    a2 + b2 = c2
    For example, 32 + 42 = 9 + 16 = 25 = 52.

    There exists exactly one Pythagorean triplet for which a + b + c = 1000.
    Find the product abc.

    Mauro Parra-Miranda
    mauropm@gmail.com
*/

#include <stdio.h> 
#include <stdlib.h>
#include <string.h> 

int main(int argc, char *argv[]){ 
  int i, j, k; 
  int sum = 0; 
  for(i=0;i<1000;i++)
    for(j=0;j<i;j++)
      for(k=0;k<j;k++)
	if ( (i+j+k==1000) )
	  if (i*i==j*j+k*k)
	    printf("a=%i,b=%i,c=%i,abc=%i\n",i,j,k,i*j*k);
  
}
