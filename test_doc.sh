
WGET_TIMEOUT=10
MD5DOCFILE="md5doc.txt"
MD5DOCFILELOCAL="md5doc.local.txt"
ARCHIVEDOC="doc.tar.bz2"


wget --timeout=${WGET_TIMEOUT}  --ftp-user 'architech' --ftp-password 'architech' ftp://engicam.smartfile.com/Document/${MD5DOCFILE} 
[ $? -eq 0 ] || { rm -f md5doc.txt; internet_error; }

if diff ${MD5DOCFILE} ${MD5DOCFILELOCAL} >/dev/null ; then
  echo Same
  rm ${MD5DOCFILE}  
else
  wget --timeout=${WGET_TIMEOUT}  --ftp-user 'architech' --ftp-password 'architech' ftp://engicam.smartfile.com/Document/${ARCHIVEDOC}
  [ $? -eq 0 ] || { rm -f ${ARCHIVEDOC}; internet_error; }
    
  tar -xvf ${ARCHIVEDOC} 
  rm -rf ${ARCHIVEDOC}
  rm -rf ${MD5DOCFILELOCAL}  
  mv ${MD5DOCFILE} ${MD5DOCFILELOCAL}  

fi

exit 0

cd ${ROOT_DIRECTORY}

