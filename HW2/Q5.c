// CSE505 HW2
// Enbo Yu - 113094714
// 14 Oct.
// compile with: gcc -o Q5 Q5.c picosat.o
#include "picosat.h"
#include <stdio.h>
int main () {
  int res;
  int N,K;
  FILE *fp;
  //  read data file
  fp=fopen("testQ5.txt","r");
  fscanf(fp,"%d %d",&N,&K);
  int m[N][N];
  for(int i=0;i<N;i++){
    for(int j=0;j<N;j++){
      fscanf(fp,"%d",&m[i][j]);
    }
  }

  //  input
  picosat_init();
  for(int i=0;i<N;i++){
    for(int j=0;j<N;j++){
      picosat_add(m[i][j]);
    }
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
