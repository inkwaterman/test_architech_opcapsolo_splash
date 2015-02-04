
WGET_TIMEOUT=10

FILECHECK="doc.tar.bz2"
DIRECTORY="doc"

ROOT_DIRECTORY=`pwd`
BASEROOT_SDK=${ROOT_DIRECTORY}


function  internet_error()
{
    exit 1;
}


ARCHIVEFILE=${FILECHECK}
MD5FILE="${ARCHIVEFILE}.md5"
MD5FILELOCAL="${DIRECTORY}/${MD5FILE}.local"
VERSIONFILE="${FILECHECK}.ver"
VERSIONFILELOCAL="${DIRECTORY}/${VERSIONFILE}.local"


wget --timeout=${WGET_TIMEOUT}  --ftp-user 'architech' --ftp-password 'architech' ftp://engicam.smartfile.com/${MD5FILE} 
[ $? -eq 0 ] || { rm -f${MD5FILE}; internet_error; }

if diff ${MD5FILE} ${MD5FILELOCAL} >/dev/null ; then
  echo Same
  rm ${MD5FILE}  
else
  wget --timeout=${WGET_TIMEOUT}  --ftp-user 'architech' --ftp-password 'architech' ftp://engicam.smartfile.com/${ARCHIVEFILE}
  [ $? -eq 0 ] || { rm -f ${ARCHIVEFILE}; internet_error; }
    
  wget --timeout=${WGET_TIMEOUT}  --ftp-user 'architech' --ftp-password 'architech' ftp://engicam.smartfile.com/${VERSIONFILE}
  [ $? -eq 0 ] || { rm -f ${VERSIONFILE}; internet_error; }
    
  if [ -d "${DIRECTORY}" ]; then
     POSTFIX=$(cat ${VERSIONFILELOCAL})
     NEWDIR="${DIRECTORY}.$POSTFIX"
     mv ${DIRECTORY} ${NEWDIR}
  fi

  tar -xvf ${ARCHIVEFILE} 
  rm -rf ${ARCHIVEFILE}

  rm -rf ${MD5FILELOCAL}  
  mv ${MD5FILE} ${MD5FILELOCAL}

  rm -rf ${VERSIONFILELOCAL}  
  mv ${VERSIONFILE} ${VERSIONFILELOCAL}

fi

exit 0

cd ${ROOT_DIRECTORY}

