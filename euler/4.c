/*  
    Euler Project
    #3

    Problem:
    A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91  99.

    Find the largest palindrome made from the product of two 3-digit numbers.

    Mauro Parra-Miranda
    mauropm@gmail.com
*/

#include <stdio.h> 
#include <stdlib.h>
#include <string.h> 

int main(int argc, char *argv[]){ 
  int strl = strlen(argv[1]);
  int i = 0; 
  int half = 0;
  int palindroma = 1; 
  half = strl/2; 
  for(i=0;i<half;i++)
    if(argv[1][i]!=argv[1][strl-1-i])
      palindroma=0; 
  if(palindroma) 
    printf("%s\n",argv[1]);
}
