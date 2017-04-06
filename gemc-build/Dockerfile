FROM tylern4/gemc-base

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
      scons libxmu-dev libx11-dev libclhep-dev libxerces-c3-dev \
      freeglut3-dev libmotif-dev tk-dev libxi-dev tcsh csh bc \
    && apt-get clean


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
    && cmake -DCMAKE_INSTALL_PREFIX=$ROOTSYS \
    -Droofit=ON -Dminuit2=ON -Dpython=ON \
    .. \
    && make -j$(nproc) && make install

## geant4
ENV GEANT4_VERSION 4.10.02.p03
ENV G4INSTALL $JLAB_SOFTWARE/geant4/$GEANT4_VERSION

RUN mkdir -p $G4INSTALL \
    cd $G4INSTALL \
    && wget $BASE_URL/geant4/geant$GEANT4_VERSION.tar.gz \
    && tar -zxpvf geant$GEANT4_VERSION.tar.gz \
    && cd geant$GEANT4_VERSION \
    && rm -rf build && mkdir build && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=$G4INSTALL \
                  -DGEANT4_INSTALL_DATA=ON \
  								-DGEANT4_USE_GDML=ON \
  								-DXERCESC_ROOT_DIR=$XERCESCROOT \
  								-DGEANT4_USE_QT=ON \
  								-DQT_QMAKE_EXECUTABLE=$QTDIR/bin/qmake \
  								-DCMAKE_INSTALL_DATAROOTDIR=$G4INSTALL/data \
  								-DCLHEP_ROOT_DIR=$CLHEP_BASE_DIR \
  								-DGEANT4_INSTALL_DATA=$DATA \
  								-DGEANT4_BUILD_EXAMPLES=OFF \
                  -DGEANT4_USE_OPENGL_X11=ON \
  								-DCMAKE_CXX_FLAGS=-I$QTDIR/include \
                  -I$QTDIR/include/QtOpenGL \
                  -I$QTDIR/include/QtWidgets \
                  -I$QTDIR/include/QtGui \
                  -I$QTDIR/include/QtCore \
                  -I$QTDIR/include/QtPrintSupport \
                  "-W -Wall -pedantic -Wno-non-virtual-dtor -Wno-long-long -Wwrite-strings -Wpointer-arith -Woverloaded-virtual -pipe" \
                  ..

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
ENV CCDB_HOME /usr/local/jlab_software/x86_64/devel/ccdb/ccdb-1.06.02
ENV CCDB_USER root

RUN mkdir -p $JLAB_SOFTWARE/ccdb \
    && cd $JLAB_SOFTWARE/ccdb \
    && wget $BASE_URL/ccdb/ccdb-$CCDB_VERSION.tar.gz \
    && tar -zxpvf ccdb-$CCDB_VERSION.tar.gz \
    && rm -rf ccdb-$CCDB_VERSION.tar.gz \
    && cd $JLAB_SOFTWARE/ccdb/ccdb-$CCDB_VERSION \
    && scons -j$(nproc) \
    && mkdir -p $CCDB_HOME \
    && cp -r $JLAB_SOFTWARE/ccdb/ccdb-$CCDB_VERSION $CCDB_HOME

## mlibrary
ENV GIT_SSL_NO_VERIFY false

RUN mkdir -p $JLAB_SOFTWARE/mlibrary \
    && cd $JLAB_SOFTWARE/mlibrary \
    && wget $BASE_URL/mlibrary/mlibrary-$MLIBRARY_VERSION.tar.gz \
    && tar -zxpvf mlibrary-$MLIBRARY_VERSION.tar.gz \
    && rm -rf mlibrary-$MLIBRARY_VERSION.tar.gz \
    && cd $JLAB_SOFTWARE/mlibrary/$MLIBRARY_VERSION \
    && scons -j$(nproc) OPT=1 \
    && mkdir cadmeshBuild \
    && cd cadmeshBuild \
    && cmake3 ../cadmesh -DCMAKE_INSTALL_PREFIX:PATH=$MLIBRARY -DCMAKE_PREFIX_PATH=$JLAB_SOFTWARE/geant4/$GEANT4_VERSION \
    && make -j$(nproc) \
    && make install

## gemc
RUN rm -rf $JLAB_SOFTWARE/gemc/$GEMC_VERSION \
    && mkdir -p $JLAB_SOFTWARE/gemc \
    && cd $JLAB_SOFTWARE/gemc \
    && wget $BASE_URL/gemc/gemc-$GEMC_VERSION.tar.gz \
    && tar -zxpvf gemc-$GEMC_VERSION.tar.gz \
    && rm -rf gemc-$GEMC_VERSION.tar.gz \
    && cd $GEMC_VERSION \
    && scons -j$(nproc) LIBRARY=shared OPT=1


COPY cshrc /root/.cshrc
WORKDIR /root/

ENTRYPOINT ["/bin/tcsh"]
