WGET_TIMEOUT=10
MD5IMGFILE="md5img.txt"
MD5IMGFILELOCAL="md5img.local.txt"
ARCHIVEIMG="opcapsolo.sdcard.tar.bz2"

mkdir -p img
cd img

wget --timeout=${WGET_TIMEOUT}  --ftp-user 'architech' --ftp-password 'architech' ftp://engicam.smartfile.com/images/${MD5IMGFILE} 
[ $? -eq 0 ] || { rm -f md5img.txt; internet_error; }

if diff ${MD5IMGFILE} ${MD5IMGFILELOCAL} >/dev/null ; then
  echo Same
  rm ${MD5IMGFILE}  
else
  wget --timeout=${WGET_TIMEOUT}  --ftp-user 'architech' --ftp-password 'architech' ftp://engicam.smartfile.com/images/${ARCHIVEIMG}
  [ $? -eq 0 ] || { rm -f ${ARCHIVEIMG}; internet_error; }
    
  tar -xjvf ${ARCHIVEIMG} 
  rm -rf ${ARCHIVEIMG}
  rm -rf ${MD5IMGFILELOCAL}  
  mv ${MD5IMGFILE} ${MD5IMGFILELOCAL}  
fi
