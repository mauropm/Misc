/*
  Euler Project
  #14

  Problem:
  The following iterative sequence is defined for the set of positive integers:

  n  n/2 (n is even)
  n  3n + 1 (n is odd)

  Using the rule above and starting with 13, we generate the following sequence:
  
  13  40  20  10  5  16  8  4  2  1
  It can be seen that this sequence (starting at 13 and finishing at 1) contains 
  10 terms. Although it has not been proved yet (Collatz Problem), it is thought 
  that all starting numbers finish at 1.

  Which starting number, under one million, produces the longest chain?

  NOTE: Once the chain starts the terms are allowed to go above one million.

  
  Mauro Parra-Miranda
  mauropm@gmail.com
*/

#include <stdio.h> 
#include <stdlib.h>
#include <string.h> 

unsigned int getsec(unsigned int ob){
  if ((ob % 2) == 0)
    return ob/2; 
  else 
    return (3*ob+1);
}

int main(int argc, char *argv[]){ 
  unsigned int limit=atol(argv[1]);
  unsigned int sec = 0; 
  unsigned int bigsec = 0;
  unsigned int bignum = 0; 
  unsigned int current = 0; 
  unsigned int i=0; 
  for(i=limit;i>1;i--){
    sec=0; 
    current=i; 
    for(current = getsec(current); current>1;current = getsec(current),sec++);
    if (sec>bigsec){
      bigsec=sec;
      bignum=i;
    }
  }
  printf("%d\n",bignum); 
}
