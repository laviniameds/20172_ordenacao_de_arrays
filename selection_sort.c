
#include "sort.h"

void selection_sort(int a[], int size){
  int i,j,i_menor,menor;
  for (i=0; i<size ; ++i){
    i_menor=i;
    for (j=i+1 ; j<size ; ++j){
      if (a[j]<a[i_menor]){
        i_menor=j;
      }
    }
    menor=a[i_menor];
    a[i_menor]=a[i];
    a[i]=menor;
  }
}
