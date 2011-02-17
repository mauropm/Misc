/*
  Euler Project
  #16

  Problem:
  What is the sum of the digits of the number 21000?
  
  Mauro Parra-Miranda
  mauropm@gmail.com
*/

#include <stdio.h> 
#include <stdlib.h>
#include <string.h> 

int main(int argc, char *argv[]){ 
  int lim = strlen(argv[1]); 
  int i = 0; 
  int sum = 0 ; 
  for(i=0; i<lim; i++)
    sum+=(int)atoi(&argv[1][i]);
  printf("%d",sum);
}
