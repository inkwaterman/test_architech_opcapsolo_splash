WGET_TIMEOUT=10
MD5SDKFILE="md5sdk.txt"
MD5SDKFILELOCAL="md5sdk.local.txt"
ARCHIVESDK="sdk.tar.bz2"
SDKBIN="poky-eglibc-i686-meta-toolchain-qt5-cortexa9hf-vfp-neon-toolchain-1.6.1.sh"


wget --timeout=${WGET_TIMEOUT}  --ftp-user 'architech' --ftp-password 'architech' ftp://engicam.smartfile.com/sdk/${MD5SDKFILE} 
[ $? -eq 0 ] || { rm -f md5sdk.txt; internet_error; }

if diff ${MD5SDKFILE} ${MD5SDKFILELOCAL} >/dev/null ; then
  echo Same
  rm ${MD5SDKFILE}  
else
  wget --timeout=${WGET_TIMEOUT}  --ftp-user 'architech' --ftp-password 'architech' ftp://engicam.smartfile.com/sdk/${ARCHIVESDK}
  [ $? -eq 0 ] || { rm -f ${ARCHIVESDK}; internet_error; }
    
  tar -xvf ${ARCHIVESDK} 
  rm -rf ${ARCHIVESDK}
  rm -rf ${MD5SDKFILELOCAL}  
  ./${SDKBIN} -y -d ./sdk
  rm -rf ${SDKBIN}
  mv ${MD5SDKFILE} ${MD5SDKFILELOCAL}  
fi
