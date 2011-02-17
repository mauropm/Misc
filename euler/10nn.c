/*
  Euler Project
  #10

  Problem:
  The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

  Find the sum of all the primes below two million.
  
  Mauro Parra-Miranda
  mauropm@gmail.com
*/

#include <stdio.h> 
#include <stdlib.h>
#include <string.h> 


int main(int argc, char *argv[]){ 
  unsigned long int limit=atol(argv[1]);
  short *bitsets = malloc(sizeof(short)*(limit+1)); 
  int i = 0; 
  int j = 0; 
  for(i=2;i<limit;bitsets[i++]=1);
  for(i = 2; i<limit; i++){
    if(bitsets[i]){
      for(j = 2; j<=(i/2); j++)
	if(bitsets[j])
	  if((i%j)==0){
	    bitsets[i]=0;
	    break;
	  }
    }
    if(bitsets[i])
      printf("%d\n",i); 
  }
}
