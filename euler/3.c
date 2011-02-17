/*  
    Euler Project
    #3

    Problem:
    The prime factors of 13195 are 5, 7, 13 and 29.

    What is the largest prime factor of the number 600851475143 ?

    Mauro Parra-Miranda
    mauropm@gmail.com
*/

#include <stdio.h> 
#include <stdlib.h>

int main(int argc, char *argv[]){ 
  long long int top = 600851475143; 
  int b = top % atol(argv[1]);
  if(!b)
    printf("1\n");
  else 
    printf("0\n"); 
}
