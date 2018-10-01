#!/bin/bash

echo "Gerando Figura 9 e Topologia Jellyfish"
sleep 5

sudo python graph.py


echo "Operações realizadas com sucesso! "
sleep 5
echo ""


echo "Iniciando as Simulações - Jellyfish com TCP"
echo ""
sudo sh ./disablemptcp.sh

sleep 10

echo ""

MEDIAECMPMPTCP=0
MEDIAKSMPTCP=0
MEDIAECMP1F=0
MEDIAECMP8F=0
MEDIAKS1F=0
MEDIAKS8F=0
MEDIAAUX=0
sudo mn -c 1> /dev/null 2> /dev/stdout

sleep 10
for((i=1; i<=1; i++))
do
        sudo killall python 1> /dev/null 2> /dev/stdout
	sleep 5
       # sudo mn -c
        echo "----------------------  executando Jellyfish TCP ECMP 10 SRVS 1 FLUXO  $i -----------------------"
        nohup sudo python build_topologyecmp1f.py
        #Backup de todos os arquivos *.err e *.out
        tar -cvzf resultado-01.tgz *.err *.out;
        #inicia a cópia para gerar o relatório (Cabeçalho) ==> Relatorio_coletadas.csv
        echo "=========================" >> Relatorio_coletadas.csv;
        #echo "#" >> Relatorio_coletadas.csv;
        echo " " >> Relatorio_coletadas.csv;
        #Separa o range das linhas 33 até a 40 para mostrar quais eram os parametros setados da topologia
        sed -n '33,40p' build_topologyecmp1f.py >> Relatorio_coletadas.csv;
        #Efetua a coleta do disya que foi direcionado para o arquivo chamado de "nohup.out", onde foi selecionado somente as três primeiras linhas
        cat nohup.out |head -3 >> Relatorio_coletadas.csv;
        #Coleta as informações pertinentes ao average, ou seja, o percentual que a geração apresentou, que será o item da tabela
        cat nohup.out | grep average >> Relatorio_coletadas.csv;
        MEDIAAUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
	MEDIAECMP1F=`echo "scale=2; ($MEDIAECMP1F + $MEDIAAUX)" | bc -l`
	#remove todos os arquivos *.err e *.out para a próxima geração de relatórios, afim de não mistrutar os dados
        rm -rf *.err *.out
done

sudo killall python 1> /dev/null 2> /dev/stdout

sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 10


for ((j=1; j<=1; j++))
do
	sudo killall python 1> /dev/null 2> /dev/stdout
        sleep 5
	#sudo mn -c
	echo "----------------------  executando Jellyfish TCP 8-Shortest 10 SRVS 1 FLUXO  $j -----------------------"
	nohup sudo python build_topologykshort1f.py
	#Backup de todos os arquivos *.err e *.out
	tar -cvzf resultado-01.tgz *.err *.out;
	#inicia a cópia para gerar o relatório (Cabeçalho) ==> Relatorio_coletadas.csv
	echo "=========================" >> Relatorio_coletadas.csv;
	#echo "#" >> Relatorio_coletadas.csv;
	echo " " >> Relatorio_coletadas.csv;
	#Separa o range das linhas 33 até a 40 para mostrar quais eram os parametros setados da topologia
        sed -n '33,40p' build_topologykshort1f.py >> Relatorio_coletadas.csv;
	#Efetua a coleta do disya que foi direcionado para o arquivo chamado de "nohup.out", onde foi selecionado somente as três primeiras linhas
	cat nohup.out |head -3 >> Relatorio_coletadas.csv;
	#Coleta as informações pertinentes ao average, ou seja, o percentual que a geração apresentou, que será o item da tabela
	cat nohup.out | grep average >> Relatorio_coletadas.csv;
	MEDIAAUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
        MEDIAKS1F=`echo "scale=2; ($MEDIAKS1F + $MEDIAAUX)" | bc -l`
	#remove todos os arquivos *.err e *.out para a próxima geração de relatórios, afim de não mistrutar os dados
	rm -rf *.err *.out
done

 sudo killall python 1> /dev/null 2> /dev/stdout
 sleep 5
 sudo mn -c 1> /dev/null 2> /dev/stdout
 sleep 10

for ((k=1; k<=1; k++))
do
	echo "----------------------  executando Jellyfish TCP ECMP 10 SRVS 8 FLUXOS $k  -----------------------"
 	nohup sudo python build_topologyecmp8f.py
 	#Backup de todos os arquivos *.err e *.out
 	tar -cvzf resultado-01.tgz *.err *.out;
 	#inicia a cópia para gerar o relatório (Cabeçalho) ==> Relatorio_coletadas.csv
 	echo "=========================" >> Relatorio_coletadas.csv;
 	#echo "#" >> Relatorio_coletadas.csv;
 	echo " " >> Relatorio_coletadas.csv;
 	#Separa o range das linhas 33 até a 40 para mostrar quais eram os parametros setados da topologia
 	sed -n '33,40p' build_topologyecmp8f.py >> Relatorio_coletadas.csv;
 	#Efetua a coleta do disya que foi direcionado para o arquivo chamado de "nohup.out", onde foi selecionado somente as três primeiras linhas
 	cat nohup.out |head -3 >> Relatorio_coletadas.csv;
 	#Coleta as informações pertinentes ao average, ou seja, o percentual que a geração apresentou, que será o item da tabela
 	cat nohup.out | grep average >> Relatorio_coletadas.csv;
 	MEDIAAUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
        MEDIAECMP8F=`echo "scale=2; ($MEDIAECMP8F + $MEDIAAUX)" | bc -l`
	#remove todos os arquivos *.err e *.out para a próxima geração de relatórios, afim de não mistrutar os dados
 	rm -rf *.err *.out
done

 sudo killall python 1> /dev/null 2> /dev/stdout
 sleep 5
 sudo mn -c 1> /dev/null 2> /dev/stdout
 sleep 10

for ((l=1; l<=1; l++))
do
	echo "----------------------  executando Jellyfish TCP 8-Shortest 10 SRVS 8 FLUXOS $l -----------------------"
 	nohup sudo python build_topologykshort8f.py
 	#Backup de todos os arquivos *.err e *.out
 	tar -cvzf resultado-01.tgz *.err *.out;
 	#inicia a cópia para gerar o relatório (Cabeçalho) ==> Relatorio_coletadas.csv
 	echo "=========================" >> Relatorio_coletadas.csv;
 	#echo "#" >> Relatorio_coletadas.csv;
 	echo " " >> Relatorio_coletadas.csv;
 	#Separa o range das linhas 33 até a 40 para mostrar quais eram os parametros setados da topologia
 	sed -n '33,40p' build_topologykshort8f.py >> Relatorio_coletadas.csv;
 	#Efetua a coleta do disya que foi direcionado para o arquivo chamado de "nohup.out", onde foi selecionado somente as três primeiras linhas
 	cat nohup.out |head -3 >> Relatorio_coletadas.csv;
 	#Coleta as informações pertinentes ao average, ou seja, o percentual que a geração apresentou, que será o item da tabela
 	cat nohup.out | grep average >> Relatorio_coletadas.csv;
 	MEDIAAUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
        MEDIAKS8F=`echo "scale=2; ($MEDIAKS8F + $MEDIAAUX)" | bc -l`
	#remove todos os arquivos *.err e *.out para a próxima geração de relatórios, afim de não mistrutar os dados
 	rm -rf *.err *.out
done
echo ""
echo "Iniciando as simulações - Jellyfish com MPTCP"
echo ""
sleep 5

sudo sh ./enablemptcp.sh

sleep 10

sudo mn -c 1> /dev/null 2> /dev/stdout

sleep 10

for((i=1; i<=1; i++))
do
        sudo killall python 1> /dev/null 2> /dev/stdout
        sleep 5
       # sudo mn -c
        echo "----------------------  executando Jellyfish MPTCP ECMP 10 SRVS 8 FLUXOS  $i -----------------------"
        nohup sudo python build_topologyecmp8fmptcp.py
        #Backup de todos os arquivos *.err e *.out
        tar -cvzf resultado-01.tgz *.err *.out;
        #inicia a cópia para gerar o relatório (Cabeçalho) ==> Relatorio_coletadas.csv
        echo "=========================" >> Relatorio_coletadas.csv;
        #echo "#" >> Relatorio_coletadas.csv;
        echo " " >> Relatorio_coletadas.csv;
        #Separa o range das linhas 33 até a 40 para mostrar quais eram os parametros setados da topologia
        sed -n '33,40p' build_topologyecmp8fmptcp.py >> Relatorio_coletadas.csv;
        #Efetua a coleta do disya que foi direcionado para o arquivo chamado de "nohup.out", onde foi selecionado somente as três primeiras linhas
        cat nohup.out |head -3 >> Relatorio_coletadas.csv;
        #Coleta as informações pertinentes ao average, ou seja, o percentual que a geração apresentou, que será o item da tabela
        cat nohup.out | grep average >> Relatorio_coletadas.csv;
        MEDIAAUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
        MEDIAECMPMPTCP=`echo "scale=2; ($MEDIAECMPMPTCP + $MEDIAAUX)" | bc -l`
        #remove todos os arquivos *.err e *.out para a próxima geração de relatórios, afim de não mistrutar os dados
        rm -rf *.err *.out
done

sudo killall python 1> /dev/null 2> /dev/stdout
sleep 5
sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 10

for ((l=1; l<=1; l++))
do
        echo "----------------------  executando Jellyfish MPTCP 8-Shortest 10 SRVS 8 FLUXOS $l -----------------------"
        nohup sudo python build_topologykshort8fmptcp.py
        #Backup de todos os arquivos *.err e *.out
        tar -cvzf resultado-01.tgz *.err *.out;
        #inicia a cópia para gerar o relatório (Cabeçalho) ==> Relatorio_coletadas.csv
        echo "=========================" >> Relatorio_coletadas.csv;
        #echo "#" >> Relatorio_coletadas.csv;
        echo " " >> Relatorio_coletadas.csv;
        #Separa o range das linhas 33 até a 40 para mostrar quais eram os parametros setados da topologia
        sed -n '33,40p' build_topologykshort8fmptcp.py >> Relatorio_coletadas.csv;
        #Efetua a coleta do disya que foi direcionado para o arquivo chamado de "nohup.out", onde foi selecionado somente as três primeiras linhas
        cat nohup.out |head -3 >> Relatorio_coletadas.csv;
        #Coleta as informações pertinentes ao average, ou seja, o percentual que a geração apresentou, que será o item da tabela
        cat nohup.out | grep average >> Relatorio_coletadas.csv;
        MEDIAAUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
        MEDIAKSMPTCP=`echo "scale=2; ($MEDIAKSMPTCP + $MEDIAAUX)" | bc -l`
        #remove todos os arquivos *.err e *.out para a próxima geração de relatórios, afim de não mistrutar os dados
        rm -rf *.err *.out
done

#####################################################
#INICIO DAS SIMULACOES COM O FAT-TREE
#####################################################


sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5
sudo killall python 1> /dev/null 2> /dev/stdout
sleep 5

cd ../../lib
echo " "
echo "======================================================================="
echo "Gerando Fat-Tree TCP ECMP 1 FLUXO "

sudo python pox.py DCController --topo=ft,4 --routing=ECMP & 1> /dev/null 2>&1 &
sleep 10

sudo python fattreetcpecmp1f.py -i iperffattree -d res/fattreetcpecmp1f/ -p  0.03 -t 10 --ecmp --iperf 1> /dev/null 2>&1

sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5
sudo killall python 1> /dev/null 2> /dev/stdout
sleep 5

echo " "
echo "======================================================================="
echo "Gerando Fat-Tree TCP ECMP 8 FLUXOS "

sudo python pox.py DCController --topo=ft,4 --routing=ECMP & 1> /dev/null 2>&1 &
sleep 10

sudo python fattreetcpecmp8f.py -i iperffattree -d res/fattreetcpecmp8f/ -p  0.03 -t 10 --ecmp --iperf 1> /dev/null 2>&1

sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5
sudo killall python 1> /dev/null 2> /dev/stdout
sleep 5

echo " "
echo "======================================================================="
echo "Gerando Fat-Tree MPTCP ECMP 8 SUBFLUXOS "

sudo python pox.py DCController --topo=ft,4 --routing=ECMP & 1> /dev/null 2>&1 &
sleep 10

sudo python fattreemptcpecmp8f.py -i iperffattree -d res/fattreemptcpecmp8f/ -p  0.03 -t 10 --ecmp --iperf 1> /dev/null 2>&1
echo "========================================================================"
echo " "

#############################################################
#FIM DAS SIMULAÇOES FAT-TREE E INICIO DO CALCULO DAS MEDIAS
#############################################################

#MEDIAS FAT-TREE
cd res/fattreetcpecmp1f/
cat *.out | grep sender | awk -F' ' '{print $5}' > data
soma=$(paste -sd+ data | bc)
div=$(cat data | wc -l)
totalftecmp1f=`echo "scale=2 ; $soma / $div" | bc`
echo "Fat-tree ecmp8 tcp 1flow average : $totalftecmp1f" > average.txt

pwd

cd ../fattreetcpecmp8f/
cat *.out | grep sender | grep SUM | awk -F' ' '{print $6}' > data
soma=$(paste -sd+ data | bc)
div=$(cat data | wc -l)
totalftecmp8f=`echo "scale=2 ; $soma / $div" | bc`
echo "ft ecmp8 tcp 8flow average : $totalftecmp8f" > average.txt

pwd

cd ../fattreemptcpecmp8f/
cat *.out | grep sender | grep SUM | awk -F' ' '{print $6}' > data
soma=$(paste -sd+ data | bc)
div=$(cat data | wc -l)
totalmptcp=`echo "scale=2 ; $soma / $div" | bc`
echo "Fat-Tree ecmp8 mptcp 8flow average : $totalmptcp" > average.txt

#MEDIAS JELLYFISH
MEDIAECMPMPTCP=`echo "scale=2; ($MEDIAECMPMPTCP / 1)" | bc -l`
MEDIAKSMPTCP=`echo "scale=2; ($MEDIAKSMPTCP / 1)" | bc -l`
MEDIAECMP1F=`echo "scale=2; ($MEDIAECMP1F / 1)" | bc -l`
MEDIAECMP8F=`echo "scale=2; ($MEDIAECMP8F / 1)" | bc -l`
MEDIAKS1F=`echo "scale=2; ($MEDIAKS1F / 1)" | bc -l`
MEDIAKS8F=`echo "scale=2; ($MEDIAKS8F / 1)" | bc -l`

echo "-------------------------------------------------------------"
echo "|CONGESTION      | FAT-TREE (10 SVRS)|  JELLYFISH (10 SVRS)  |" 
echo "|CONTROL         |        ECMP       |ECMP  |8-SHORTEST PATHS|"
echo "|------------------------------------------------------------|"
echo "|TCP 1 FLOW      |         $totalftecmp1f%    |$MEDIAECMP1F%|   $MEDIAKS1F%       |"
echo "|TCP 8 FLOWS     |         $totalftecmp8f%    |$MEDIAECMP8F%|   $MEDIAKS8F%       |"
echo "|MPTCP 8 SUBFLOWS|         $totalmptcp%    |$MEDIAECMPMPTCP%|   $MEDIAKSMPTCP%       |"
echo "-------------------------------------------------------------"

echo "Execuções realizadas com Sucesso"
