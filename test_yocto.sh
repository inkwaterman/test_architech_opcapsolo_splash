
# Yocto installation

YOCTO_DIRECTORY="yocto"

mkdir -p ${YOCTO_DIRECTORY}
cd ${YOCTO_DIRECTORY}
if [ ! -d .repo ]
then
    repo init -u https://github.com/Freescale/fsl-community-bsp-platform -b daisy
    [ $? -eq 0 ] || { rm -rf .repo; internet_error; }
fi
repo sync 

cd sources/

if [ -d "meta-engicam" ]; then
    cd meta-engicam
    git pull origin master
    cd ..
else
    git clone https://github.com/engicam-stable/meta-engicam.git
fi

if [ -d "meta-qt5" ]; then
    cd meta-qt5
    git pull origin master
    cd ..
else
    git clone https://github.com/meta-qt5/meta-qt5.git -b daisy
fi

cd ..

if [ -d "build_opcapsolo" ]; then
    cd build_opcapsolo
    git pull origin master
    cd ..
else
    git clone https://github.com/inkwaterman/build_opcapsolo.git
fi


