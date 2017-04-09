FROM tylern4/gemc-base:latest

ENV JLAB_ROOT /opt/jlab_software

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


RUN cd $JLAB_ROOT \
    && wget http://www.jlab.org/12gev_phys/packages/sources/ceInstall/ceInstall_devel.tar.gz \
    && tar -zxpvf ceInstall_devel.tar.gz

COPY install_all /opt/jlab_software/devel/install
WORKDIR $JLAB_ROOT/devel/install

RUN csh install_all

COPY cshrc /root/.cshrc
WORKDIR /root/
ADD https://www.jlab.org/12gev_phys/packages/gcards/clas12.gcard /root/
ADD https://www.jlab.org/12gev_phys/packages/gcards/experiments.tar /root/

ENTRYPOINT ["/bin/tcsh"]
