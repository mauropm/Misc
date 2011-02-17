/*  
    Euler Project
    #8

    Problem:
    Find the greatest product of five consecutive digits in the 1000-digit number.

    Mauro Parra-Miranda
    mauropm@gmail.com
*/

#include <stdio.h> 
#include <stdlib.h>
#include <string.h> 

int main(int argc, char *argv[]){ 
  int strl = strlen(argv[1]);
  int i = 0; 
  int top =strl - 4 - 1;
  for(i=0;i<top;i++)
    printf("%c%c%c%c%c\n",argv[1][i],argv[1][i+1],argv[1][i+2],argv[1][i+3],argv[1][i+4]);
}
