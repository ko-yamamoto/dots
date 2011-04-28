#!/bin/sh

files="./*"
cPath=`pwd`

for filepath in ${files} ; do

  if [ "${filepath}" != "pullAll.sh" ] ; then
    echo "${filepath}の処理開始"
    cd ${filepath}
    ( git pull ) && echo "git pull処理終了"
  fi

  cd ${cPath}

done

