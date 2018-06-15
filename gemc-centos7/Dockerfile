#FROM tylern4/gemc-base:latest
FROM centos:7
ENV TERM xterm

ENV JLAB_ROOT /opt/jlab_software
ENV JLAB_VERSION devel
ENV JLAB_SOFTWARE $JLAB_ROOT/$JLAB_VERSION
ENV BASE_URL https://www.jlab.org/12gev_phys/packages/sources
RUN mkdir -p $JLAB_SOFTWARE

ENV QTDIR /usr/include/qt5
ENV PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig

ENV G4DATA_VERSION devel
ENV CLHEP_VERSION devel
ENV GEANT4_VERSION devel
ENV EVIO_VERSION devel
ENV XERCESC_VERSION devel
ENV CCDB_VERSION devel
ENV MLIBRARY_VERSION devel
ENV SCONS_BM_VERSION devel
ENV BANKS_VERSION devel
ENV GEMC_VERSION devel
ENV JANA_VERSION devel

ENV CLHEP_BASE_DIR $JLAB_SOFTWARE/clhep
ENV G4INSTALL $JLAB_SOFTWARE/geant4
ENV EVIO $JLAB_SOFTWARE/evio
ENV MYSQL $JLAB_SOFTWARE/mysql
ENV XERCESCROOT $JLAB_SOFTWARE/xercesc
ENV CCDB_HOME $JLAB_SOFTWARE/CCDB
ENV MLIBRARY $JLAB_SOFTWARE/mlibrary
ENV GEMC $JLAB_SOFTWARE/gemc
ENV JANA_HOME $JLAB_SOFTWARE/jana
ENV SCONS_BM $JLAB_SOFTWARE/scons_bm
ENV BANKS $JLAB_SOFTWARE/banks

ENV PYTHONPATH $PYTHONPATH:$SCONS_BM

## mysql
ENV MYSQL $JLAB_SOFTWARE/mysql
ENV MYSQBIN $MYSQL/bin
ENV MYSQINC $MYSQL/include
ENV MYSQLIB $MYSQL/lib
ENV MYSQLINC $MYSQL/include
ENV MYSQL_INCLUDE_PATH $MYSQL/include
ENV MYSQL_LIB_PATH $MYSQL/lib

RUN mkdir -p $JLAB_SOFTWARE/mysql \
    && ln -sfn /usr/lib/x86_64-linux-gnu $JLAB_SOFTWARE/mysql/lib \
    && ln -sfn /usr/include/mysql $JLAB_SOFTWARE/mysql/include


RUN yum update -y && yum -y install epel-release \
    && yum install -y git cmake cmake3 gcc-c++ gcc binutils bash parallel \
    make libX11-devel libXpm-devel libXft-devel libXext-devel xbae-devel libXaw-devel \
    subversion scons patch expat-devel mysql-devel bzip2-devel \
    blas-devel blas-static lapack-devel lapack-static bzip2 zsh qt5 \
    sqlite-devel gcc-gfortran openssl-devel pcre-devel \
    mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel \
    fftw-devel cfitsio-devel graphviz-devel which mv \
    avahi-compat-libdns_sd-devel libldap-dev python-devel \
    libxml2-devel gsl-static xz tar file scons openmotif-devel \
    wget libXmu-devel libXp-devel libXt-devel libjpeg-devel libpng-devel \
    tcl tcl-devel tk tk-devel imake libtool openmpi openmpi-devel qt5-qtbase-devel qt5-linguist \
    && yum clean all && rm -rf /var/cache/yum

## ROOT
#ENV ROOT_VERSION 6-08-04
ENV ROOT_VERSION 5-34-36
ENV ROOTSYS $JLAB_SOFTWARE/root
RUN alias cmake='cmake3' && mkdir -p $ROOTSYS && cd $ROOTSYS \
    && curl -o v$ROOT_VERSION.tar.gz https://codeload.github.com/root-project/root/tar.gz/v$ROOT_VERSION \
    && tar -zxpvf v$ROOT_VERSION.tar.gz \
    && rm -rf v$ROOT_VERSION.tar.gz \
    && cd root-$ROOT_VERSION \
    && mkdir compile && cd compile \
    && cmake3 -Dminimal=ON -DCMAKE_INSTALL_PREFIX=$ROOTSYS .. \
    && make -j$(nproc) && make install \
    && rm -rf $JLAB_SOFTWARE/root/root-$ROOT_VERSION

## scons
ENV SCONSFLAGS --site-dir=$SCONS_BM
RUN git clone https://github.com/maureeungaro/scons_bm.git $SCONS_BM 

## EVIO
ENV EVIO_VERSION 5.1
RUN mkdir -p $EVIO && cd $EVIO \
    && curl -o evio-$EVIO_VERSION.tar.gz $BASE_URL/evio/evio-$EVIO_VERSION.tar.gz \
    && tar -xvf evio-$EVIO_VERSION.tar.gz --strip-components 1 \
    && rm -rf evio-$EVIO_VERSION.tar.gz \
    && scons -j$(nproc)

##CLHEP
RUN mkdir -p $CLHEP_BASE_DIR \
    && cd $CLHEP_BASE_DIR \
    && git clone https://gitlab.cern.ch/CLHEP/CLHEP.git github-source \
    && mkdir build && cd build \
  	&& cmake3 -DCMAKE_INSTALL_PREFIX=$CLHEP_BASE_DIR -DCMAKE_CXX_FLAGS=-fPIC $CLHEP_BASE_DIR/github-source \
    && make -j$(nproc) \
    && make install \
    && rm -rf $CLHEP_BASE_DIR/github-source

## xercesc
RUN mkdir -p $XERCESCROOT \
    && cd $XERCESCROOT \
    && git clone https://github.com/apache/xerces-c.git github-source \
    && mkdir build && cd build \
    && cmake3 -DCMAKE_INSTALL_PREFIX=$XERCESCROOT $XERCESCROOT/github-source \
    && make -j$(nproc) \
    && make install \
    && rm -rf $XERCESCROOT/github-source

## geant4
RUN mkdir -p $G4INSTALL \
    && cd $G4INSTALL \
    && git clone https://github.com/Geant4/geant4.git $G4INSTALL/github-source \
    && mkdir -p $G4INSTALL/build \
    && cd $G4INSTALL/build \
    && cmake3 -DGEANT4_USE_OPENGL_X11=ON -DCMAKE_INSTALL_PREFIX=$G4INSTALL \
              -DGEANT4_USE_GDML=ON \
              -DGEANT4_INSTALL_DATA=ON \
              -DGEANT4_BUILD_MULTITHREADED=ON \
              -DXERCESC_ROOT_DIR=$XERCESCROOT \
              -DGEANT4_USE_QT=ON \
              -DCMAKE_INSTALL_DATAROOTDIR=$G4INSTALL/data \
              -DCLHEP_ROOT_DIR=$CLHEP_BASE_DIR \
              -DGEANT4_INSTALL_DATA=$DATA \
              -DGEANT4_BUILD_EXAMPLES=OFF \
              -DCMAKE_CXX_FLAGS="-W -Wall -pedantic -Wno-non-virtual-dtor -Wno-long-long -Wwrite-strings -Wpointer-arith -Woverloaded-virtual -pipe" \
              $G4INSTALL/github-source \
    && make -j$(nproc) \
    && make install \
    && rm -rf $G4INSTALL/github-source

## CCDB_HOME
ENV QTDIR /usr/include/qt5
RUN git clone https://github.com/JeffersonLab/CCDB.git $CCDB_HOME \
    && cd $CCDB_HOME \
    && rm -rf .git* \
    && scons -j$(nproc)


ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$CCDB_HOME/lib
ENV PATH $PATH:$CCDB_HOME/bin
ENV PYTHONPATH $PYTHONPATH:$CCDB_HOME/python


ENV CADMESH $JLAB_SOFTWARE/cadmesh
RUN git clone -b v1.1 https://github.com/christopherpoole/CADMesh.git  $CADMESH/github-source \
    && mkdir -p $CADMESH/build && cd $CADMESH/build \
    && cmake3 $CADMESH/github-source -DCMAKE_CXX_FLAGS=-fPIC -DCMAKE_PREFIX_PATH=$G4INSTALL \
    && make -j$(nproc) \
    && make install \
    && rm -rf $CADMESH/github-source


## mlibrary
RUN git clone https://github.com/gemc/mlibrary.git $MLIBRARY \
    && cd $MLIBRARY \
    && rm -rf .git* \
    && scons -j$(nproc) OPT=1

## gemc
ENV GEMC_VERSION 2.6
RUN git clone -b patch-1 https://github.com/tylern4/source.git $GEMC \
    && cd $GEMC \
    && scons OPT=1 -j$(nproc)

#RUN mkdir -p $GEMC \
#    && cd $GEMC \
#    && curl -o gemc-$GEMC_VERSION.tar.gz $BASE_URL/gemc/gemc-$GEMC_VERSION.tar.gz \
#    && tar -xvf gemc-$GEMC_VERSION.tar.gz --strip-components 1 \
#    && rm -rf gemc-$GEMC_VERSION.tar.gz \
#    && scons OPT=1 -j$(nproc)

##Banks
#ENV BANKS_VERSION 1.4
#RUN mkdir -p $JLAB_SOFTWARE/banks \
#    && cd $JLAB_SOFTWARE/banks \
#    && curl -o banks-$BANKS_VERSION.tar.gz $BASE_URL/banks/banks_$BANKS_VERSION.tar.gz \
#    && tar -xvf banks-$BANKS_VERSION.tar.gz --strip-components 1 \
#    && rm -rf banks-$BANKS_VERSION.tar.gz \
#    && scons -j$(nproc) OPT=1

##JANA_HOME
#RUN git clone https://github.com/JeffersonLab/JANA.git $JANA_HOME \
#    && cd $JANA_HOME \
#    && rm -rf .git* \
#    && scons -j$(nproc)

## Fields
#RUN mkdir -p $JLAB_ROOT/noarch/data \
#   && cd $JLAB_ROOT/noarch/data \
#   && rm -rf srr* clas12* \
#   && curl -o clas12SolenoidFieldMap.dat http://clasweb.jlab.org/12gev/field_maps/clas12SolenoidFieldMap.dat \
#   && curl -o clas12TorusOriginalMap.dat http://clasweb.jlab.org/12gev/field_maps/clas12TorusOriginalMap.dat

WORKDIR /root/
COPY env.sh /root/.zshrc
COPY env.sh /root/.bashrc

ENTRYPOINT ["zsh"]
