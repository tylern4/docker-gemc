FROM tylern4/gemc-base:latest

ENV JLAB_ROOT /opt/jlab_software
ENV JLAB_VERSION devel
ENV OSRELEASE Linux__Ubuntu16.10-x86_64-gcc6.2.0
ENV JLAB_SOFTWARE $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE
ENV BASE_URL https://www.jlab.org/12gev_phys/packages/sources

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get -y install zsh perl git dpkg-dev cmake g++ gcc \
      binutils libx11-dev libxpm-dev \
      libxft-dev libxext-dev gfortran libssl-dev libpcre3-dev \
      xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
      libmysqlclient-dev libfftw3-dev libcfitsio-dev \
      graphviz-dev libavahi-compat-libdnssd-dev \
      libldap2-dev python-dev libxml2-dev libkrb5-dev \
      libgsl0-dev python-pip wget curl python-tk \
      scons libxmu-dev libx11-dev \
      freeglut3-dev libmotif-dev tk-dev libxi-dev tcsh csh bc \
    && apt-get clean
#libclhep-dev libxerces-c3-dev

## QT 5.8
ENV QT_VERSION 5.8.0
ENV QT_BIN_VERSION 5.8
ENV QTSYSTEM gcc_64
ENV QTDIR $JLAB_SOFTWARE/qt/$QT_VERSION/$QT_BIN_VERSION/$QTSYSTEM
ENV PKG_CONFIG_PATH $QTDIR/lib/pkgconfig

## ROOT
ENV ROOTV_DOT 6.08.04
ENV ROOTV_SLASH 6-08-04
ENV ROOTSYS $JLAB_SOFTWARE/root/$ROOTV_DOT

RUN wget https://github.com/root-project/root/archive/v$ROOTV_SLASH.tar.gz \
    && tar -zxpvf v$ROOTV_SLASH.tar.gz \
    && rm -rf v$ROOTV_SLASH.tar.gz \
    && cd root-$ROOTV_SLASH \
    && mkdir compile && cd compile \
    && cmake -DCMAKE_INSTALL_PREFIX=$ROOTSYS -DCMAKE_CXX_FLAGS=-fPIC \
    -Droofit=ON -Dminuit2=ON -Dpython=ON \
    .. \
    && make -j$(nproc) && make install

##CLHEP
ENV CLHEP_VERSION 2.3.4.3
ENV CLHEP_BASE_DIR $JLAB_SOFTWARE/clhep/$CLHEP_VERSION

RUN mkdir -p $CLHEP_BASE_DIR \
    && cd $CLHEP_BASE_DIR/.. \
    && rm -rf build && mkdir build \
    && rm -rf source && mkdir source \
    && cd source \
    && wget $BASE_URL/clhep/clhep-$CLHEP_VERSION.tgz \
    && tar -zxpvf clhep-$CLHEP_VERSION.tgz \
    && rm -rf clhep-$CLHEP_VERSION.tgz \
    && cd $CLHEP_BASE_DIR/../build \
  	&& cmake -DCMAKE_INSTALL_PREFIX=$CLHEP_BASE_DIR -DCMAKE_CXX_FLAGS=-fPIC $CLHEP_BASE_DIR/../source/$CLHEP_VERSION/CLHEP \
    && make -j$(nproc) && make install

## xercesc
ENV XERCESC_VERSION 3.1.4
ENV XERCESCROOT $JLAB_SOFTWARE/xercesc/$XERCESC_VERSION

RUN wget $BASE_URL/xercesc/xerces-c-$XERCESC_VERSION.tar.gz \
    && tar -xvf xerces-c-$XERCESC_VERSION.tar.gz \
    && rm -rf xerces-c-$XERCESC_VERSION.tar.gz \
    && cd xerces-c-$XERCESC_VERSION \
    && ./configure -prefix=$XERCESCROOT \
    && make -j $(nproc) && make install

## geant4
ENV GEANT4_VERSION 4.10.02.p03
ENV G4INSTALL $JLAB_SOFTWARE/geant4/$GEANT4_VERSION
ENV GEANT4_DOWNLOAD http://geant4.web.cern.ch/geant4/support/source/geant$GEANT4_VERSION.tar.gz
ENV G4DATA_VERSION 10.3.0
ENV Geant4_DIR $JLAB_SOFTWARE/geant4/$GEANT4_VERSION/lib/Geant4-10.2.3

COPY scripts /opt/jlab_software/devel
RUN cd /opt/jlab_software/devel \
    && tcsh go_geant4

#RUN mkdir -p $G4INSTALL/source \
#    && cd $G4INSTALL/source \
#    && wget $GEANT4_DOWNLOAD \
#    && tar -zxpvf geant$GEANT4_VERSION.tar.gz \
#    && cd geant$GEANT4_VERSION \
#    && rm -rf build && mkdir build && cd build \
#    && cmake -DGEANT4_USE_OPENGL_X11=ON \
#        -DCMAKE_INSTALL_PREFIX=$G4INSTALL \
#        -DGEANT4_USE_GDML=ON \
#        -DGEANT4_USE_QT=ON \
#        -DQT_QMAKE_EXECUTABLE=$QTDIR/bin/qmake \
#        -DGEANT4_INSTALL_DATA=ON \
#        -DGEANT4_BUILD_EXAMPLES=OFF \
#        -DCMAKE_CXX_FLAGS=-I$QTDIR/include -I$QTDIR/include/QtOpenGL -I$QTDIR/include/QtWidgets -I$QTDIR/include/QtGui -I$QTDIR/include/QtCore -I$QTDIR/include/QtPrintSupport -W -Wall -pedantic -Wno-non-virtual-dtor -Wno-long-long -Wwrite-strings -Wpointer-arith -Woverloaded-virtual -pipe \
#      .. \
#    && make -j$(nproc) && make install


## scons
ENV SCONS_BM_VERSION devel
ENV SCONSFLAGS --site-dir=$JLAB_ROOT/$JLAB_VERSION/scons_bm/$SCONS_BM_VERSION

RUN rm -rf $JLAB_ROOT/$JLAB_VERSION/scons_bm/$SCONS_BM_VERSION \
    && mkdir -p $JLAB_ROOT/$JLAB_VERSION/scons_bm/ \
    && cd $JLAB_ROOT/$JLAB_VERSION/scons_bm/ \
    && wget $BASE_URL/scons_bm/scons_bm-$SCONS_BM_VERSION.tar.gz \
    && tar -zxpvf scons_bm-$SCONS_BM_VERSION.tar.gz \
    && rm -rf scons_bm-$SCONS_BM_VERSION.tar.gz

## EVIO
ENV EVIO_VERSION 5.1
ENV EVIO $JLAB_SOFTWARE/evio/$EVIO_VERSION

RUN mkdir -p $JLAB_SOFTWARE/evio && cd $JLAB_SOFTWARE/evio \
    && wget $BASE_URL/evio/evio-$EVIO_VERSION.tar.gz \
    && tar -zxpvf evio-$EVIO_VERSION.tar.gz \
    && rm -rf evio-$EVIO_VERSION.tar.gz \
    && cd $EVIO_VERSION \
    && scons -j$(nproc)

## mysql
ENV MYSQL $JLAB_SOFTWARE/mysql
ENV MYSQBIN $MYSQL/bin
ENV MYSQINC $MYSQL/include
ENV MYSQLIB $MYSQL/lib
ENV MYSQLINC $MYSQL/include
ENV MYSQL_INCLUDE_PATH $MYSQL/include
ENV MYSQL_LIB_PATH $MYSQL/lib

RUN mkdir -p $JLAB_SOFTWARE/mysql \
    && ln -sfn /usr/lib64/mysql $JLAB_SOFTWARE/mysql/lib

## CCDB
ENV CCDB_VERSION 1.06.02
ENV CCDB_HOME $JLAB_SOFTWARE/ccdb/ccdb-$CCDB_VERSION
ENV CCDB_USER root

RUN mkdir -p $JLAB_SOFTWARE/ccdb \
    && cd $JLAB_SOFTWARE/ccdb \
    && wget $BASE_URL/ccdb/ccdb-$CCDB_VERSION.tar.gz \
    && tar -zxpvf ccdb-$CCDB_VERSION.tar.gz \
    && rm -rf ccdb-$CCDB_VERSION.tar.gz \
    && cd $JLAB_SOFTWARE/ccdb/ccdb-$CCDB_VERSION \
    && scons -j$(nproc) \
    && mkdir -p $CCDB_HOME

## mlibrary
ENV GIT_SSL_NO_VERIFY fals
ENV MLIBRARY_VERSION devel
ENV MLIBRARY $JLAB_SOFTWARE/mlibrary/$MLIBRARY_VERSION

RUN mkdir -p $JLAB_SOFTWARE/mlibrary \
    && cd $JLAB_SOFTWARE/mlibrary \
    && wget $BASE_URL/mlibrary/mlibrary-$MLIBRARY_VERSION.tar.gz \
    && tar -zxpvf mlibrary-$MLIBRARY_VERSION.tar.gz \
    && rm -rf mlibrary-$MLIBRARY_VERSION.tar.gz \
    && cd $JLAB_SOFTWARE/mlibrary/$MLIBRARY_VERSION \
    && scons -j$(nproc) OPT=1 -fPIC \
    && git clone https://github.com/christopherpoole/CADMesh.git cadmesh \
    && mkdir cadmeshBuild \
    && cd cadmeshBuild \
    && cmake ../cadmesh -DCMAKE_CXX_FLAGS=-fPIC -DCMAKE_INSTALL_PREFIX:PATH=$MLIBRARY -DCMAKE_PREFIX_PATH=$JLAB_SOFTWARE/geant4/$GEANT4_VERSION \
    && make -j$(nproc) \
    && make install

## gemc
ENV GEMC_VERSION devel
ENV GEMC $JLAB_SOFTWARE/gemc/$GEMC_VERSION

COPY scripts /opt/jlab_software/devel
RUN cd /opt/jlab_software/devel \
    && tcsh go_gemc

#RUN rm -rf $JLAB_SOFTWARE/gemc/$GEMC_VERSION \
#    && mkdir -p $JLAB_SOFTWARE/gemc \
#    && cd $JLAB_SOFTWARE/gemc \
#    && wget $BASE_URL/gemc/gemc-$GEMC_VERSION.tar.gz \
#    && tar -zxpvf gemc-$GEMC_VERSION.tar.gz \
#    && rm -rf gemc-$GEMC_VERSION.tar.gz \
#    && cd $GEMC_VERSION \
#    && scons -j$(nproc) OPT=1

## Fields
RUN mkdir -p $JLAB_ROOT/noarch/data \
    && cd $JLAB_ROOT/noarch/data \
    && rm -rf srr* clas12* \
    && wget http://clasweb.jlab.org/12gev/field_maps/clas12SolenoidFieldMap.dat \
    && wget http://clasweb.jlab.org/12gev/field_maps/clas12TorusOriginalMap.dat


COPY cshrc /root/.cshrc
WORKDIR /root/

ENTRYPOINT ["/bin/tcsh"]
