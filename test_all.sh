#!/bin/bash

CMD_MERGE=./test_merge
CMD_SELECTION=./test_selection
RESULT_FILE=results.csv
LOG_FILE=test.log
GCC=$(which gcc)

echo "$(date) Mensagens geradas em ${LOG_FILE}."

echo "$(date) Compilar test_merge" > ${LOG_FILE}
gcc -Wall -ansi -O2 -o ${CMD_MERGE} test_merge.c merge_sort.c selection_sort.c
if [ $? == 0 ]; then # Erro de compilação
  echo "$(date) Compilação de ${CMD_MERGE} concluída com sucesso!" >> ${LOG_FILE}
else
  echo "$(date) Erro ao compilar fontes para ${CMD_MERGE}. Abortando testes!!!!" >> ${LOG_FILE}
  echo "Erro: Verifique o arquivo ${LOG_FILE}"
  exit 1
fi

echo "$(date) Compilar test_selection" >> ${LOG_FILE}
gcc -Wall -ansi -O2 -o ${CMD_SELECTION} test_selection.c merge_sort.c selection_sort.c
if [ $? == 0 ]; then # Erro de compilação
  echo "$(date) Compilação de ${CMD_SELECTION} comcluída com sucesso!" >> ${LOG_FILE}
else
  echo "$(date) Erro ao compilar fontes para ${CMD_SELECTION}. Abortando testes!!!!" >> ${LOG_FILE}
  echo "Erro: Verifique o arquivo ${LOG_FILE}"
  exit 1
fi

echo "Tamanho;Selection;merge" > ${RESULT_FILE} 
for tam in 00256 00512 01024 02048 04096 08192 16384 32768; do
  ok_s=0
  ok_m=0
  total=0
  sum_s=0.0
  sum_m=0.0
  for test in 01 02 03 04 05 06 07 08 09 10; do
    # Seleção
    ARQUIVO="tests/test_${tam}_${test}.txt"
    echo "$(date) Executando ${COM_SELECTION} com arquivo de entrada ${ARQUIVO}" >> ${LOG_FILE}
    result=$(${CMD_SELECTION} < ${ARQUIVO})
    if [ "$(echo ${result} | cut -d: -f1)" == "OK"  ]; then
      t=$(echo ${result} | cut -d: -f2)
      echo "$(date) Ordenação com Seleção OK em ${ARQUIVO} com tempo ${t}" >> ${LOG_FILE}
      sum_s=$(echo $sum_s+${t} | bc -l)
      let "ok_s+=1"
    else
      echo  "$(date) Ordenação com Seleção NÃO OK em ${ARQUIVO}"  >> ${LOG_FILE}
    fi
    # Merge
    result=$(${CMD_MERGE} < tests/test_${tam}_${test}.txt)
    if [ "$(echo ${result} | cut -d: -f1)" == "OK"  ]; then
      t=$(echo ${result} | cut -d: -f2)
      echo "$(date) Ordenação com Merge OK em ${ARQUIVO} com tempo ${t}"  >> ${LOG_FILE}
      sum_m=$(echo $sum_m+${t} | bc -l)
      let "ok_m+=1"
    else
      echo  "$(date) Ordenação com Merge NÃO OK em ${ARQUIVO}"  >> ${LOG_FILE}
    fi
    let "total+=1"
  done
  res_s="-"
  res_m="-"
  if [ ${ok_s} -eq ${total} ]; then
    res_s=$(echo ${sum_s}/${ok_s} | bc -l)
  fi
  if [ ${ok_m} -eq ${total} ]; then
    res_m=$(echo ${sum_m}/${ok_m} | bc -l)
  fi
  echo "${tam};${res_s};${res_m}" >> ${RESULT_FILE}
done

echo "$(date) Testes finalizados. Veja resultado no arquivo ${FILE}" >> ${LOG_FILE}
