#!/bin/bash


source bkp-mysql.conf

function @CRIAPASTADIARIA () {
        mkdir -p $MYSQL/$DATA
	}



function @BACKUPMYSQL () {

LISTAMYSQL=`mysqlshow -t --user=$USER --password=$SENHA |awk {'print$2'} |grep -v "Databases" |grep -v "^ *$"`

                for BASE in $LISTAMYSQL; do

                        echo " Efetuando DUMP da base $BASE..."
                        $DUMP --host=$HOST --user=$USER --password=$SENHA --databases $BASE > $MYSQL/$BASE.sql
                        echo ""

                done;
                }



function @COPIADUMPSTORAGE () {
	chmod 777 $MYSQL/$DATA/*.sql
	cd $PMONTAGEM
	cp -a $MYSQL/$DATA/  .
	}

@CRIAPASTADIARIA
@BACKUPMYSQL


echo "Copiando os Dumps para o NAS ou HD EXTERNO"
echo "Iniciando a copia"
@COPIADUMPSTORAGE
echo "Backup efetuado com sucesso!!!"
echo "Arquivos Copiados para:" $PMONTAGEM
echo "Backup efetuado com sucesso!!!"
