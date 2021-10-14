// compile with: gcc -o Q4 Q4.c picosat.o
#include "picosat.h"
#include <stdio.h>
int main () {
  int res;
  int M,N,K;
  FILE *fp;
  //  read data file
  fp=fopen("testQ4.txt","r");
  fscanf(fp,"%d %d %d",&K,&N,&M);
  int m[M][2];
  for(int i=0;i<M;i++){
    fscanf(fp,"%d %d",&m[i][0],&m[i][1]);
  }

  //  input
  picosat_init();
  for(int i=0;i<M;i++){
    picosat_add(m[i][0]);
    picosat_add(m[i][1]);
    picosat_add(0);
  }
  
  // output result
  res = picosat_sat(1);
  if (res <= K)
    printf ("s SATISFIABLE\n");
  else if (res > K)
    printf ("s UNSATISFIABLE\n");
  else
    printf ("s UNKNOWN\n");

  return 0;
}
