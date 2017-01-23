#!/bin/bash

IFS=""
CONTNAME="pdfxchg-wine"

function run_existing_container()
{
	docker exec ${CONTNAME} /root/pdfxcview.sh "$1"
}

function run_new_container()
{
	docker rm ${CONTNAME} &>/dev/null; \
	docker run --name ${CONTNAME} \
	-d \
	-v $HOME:/mnt \
	--net="none" \
	-e H="$HOME" \
	-e DISPLAY="$DISPLAY" \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	${CONTNAME} /root/pdfxcview.sh -m "$1"

}

for a in $*
do
  if ! echo $a | egrep -q '^(\~|\/)'
  then
    a=${PWD}/$a
  fi

  arr[i]=$a
  i=$(( i+= 1 ))
done


if [ ${#arr[@]} -gt 1 ]
then
	if docker ps -f name=${CONTNAME} -q | grep -q '[0-9a-z]*'
	then
		for a in $arr
		do
			run_existing_container "${a}"
		done
	else
		run_new_container "${arr[0]}"
		for a in ${arr[@]:1}
		do
			run_existing_container "${a}"
		done
	fi
else
	if docker ps -f name=${CONTNAME} -q | grep -q '[0-9a-z]*'
	then
		run_existing_container "${arr[0]}"
	else
		run_new_container "${arr[0]}"
	fi
fi

