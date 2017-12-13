#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "sort.h"

int check_sorted(int a[], int size){
  int i,sorted;
  sorted=1;
  for (i=1 ; i<size ; ++i){
    if (a[i-1]>a[i]){
      sorted=0;
      break;
    }
  }
  return sorted;
}

int main(){
  int i,size,*a;
  scanf("%d",&size);
  a = (int*)malloc(sizeof(int)*size);
  for (i=0 ; i<size ; ++i)
    scanf("%d",&a[i]);
  clock_t begin = clock();
  selection_sort(a,size);
  clock_t end = clock();
  double time_spent = (double)(end - begin) / (CLOCKS_PER_SEC/1000);
  if (check_sorted(a,size)){
    /* Ordenado */
    printf("OK:%lf\n",time_spent);
  } else {
    /* Não ordenado */
    printf("NOK:%lf\n",time_spent);
  }
  return 0;
}
