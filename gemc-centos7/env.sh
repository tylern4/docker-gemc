export JLAB_ROOT=/opt/jlab_software
export JLAB_VERSION="devel"
export JLAB_SOFTWARE=$JLAB_ROOT/$JLAB_VERSION
export BASE_URL=https://www.jlab.org/12gev_phys/packages/sources
export QTDIR=/usr/include/qt5
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

export G4DATA_VERSION="devel"
export CLHEP_VERSION="devel"
export GEANT4_VERSION="devel"
export EVIO_VERSION="devel"
export XERCESC_VERSION="devel"
export CCDB_VERSION="devel"
export MLIBRARY_VERSION="devel"
export SCONS_BM_VERSION="devel"
export BANKS_VERSION="devel"
export GEMC_VERSION="devel"
export JANA_VERSION="devel"

export CLHEP_BASE_DIR=$JLAB_SOFTWARE/clhep
export CADMESH=$JLAB_SOFTWARE/cadmesh
export G4INSTALL=$JLAB_SOFTWARE/geant4
export EVIO=$JLAB_SOFTWARE/evio
export MYSQL=$JLAB_SOFTWARE/mysql
export XERCESCROOT=$JLAB_SOFTWARE/xercesc
export CCDB_HOME=$JLAB_SOFTWARE/CCDB
export MLIBRARY=$JLAB_SOFTWARE/mlibrary
export GEMC=$JLAB_SOFTWARE/gemc
export JANA_HOME=$JLAB_SOFTWARE/jana
export SCONS_BM=$JLAB_SOFTWARE/scons_bm
export BANKS=$JLAB_SOFTWARE/banks
export PYTHONPATH=$PYTHONPATH:$SCONS_BM

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CCDB_HOME/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CADMESH/build/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CLHEP_BASE_DIR/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$EVIO/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$G4INSTALL/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GEMC/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MLIBRARY/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYSQL/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$XERCESCROOT/lib64

export PATH=$PATH:$GEMC
alias gemc='gemc -USE_GUI=0'

export DATA=/opt/jlab_software/noarch/data
export G4DATA=$DATA/g4data
export G4ENSDFSTATEDATA=$G4DATA/G4ENSDFSTATE2.1
export G4LEVELGAMMADATA=$G4DATA/PhotonEvaporation4.3.2/correlated_gamma
#CERN ROOT
export ROOTSYS=$JLAB_SOFTWARE/root/6-08-04
export PATH=$ROOTSYS/bin:$PATH
export PYTHONDIR=$ROOTSYS
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH:$ROOTSYS/bindings/pyroot

alias ls='ls --color=auto'
if [[ $0 == "zsh" ]]; then
  autoload -U colors
  colors
  setopt prompt_subst
  PROMPT='%{$fg[white]%}[%{$fg[green]%}docker:%~%{$fg[white]%}] %{$reset_color%}'
else
  export PS1="[\[$(tput sgr0)\]\[\033[38;5;70m\]docker\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;70m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]] \[$(tput sgr0)\]"
fi
