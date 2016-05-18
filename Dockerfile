FROM centos:latest
MAINTAINER eLISA DPC ccavet@apc.in2p3.fr

RUN yum -y update
RUN yum install -y epel-release
RUN yum install -y git 
RUN yum install -y make
RUN yum install -y cmake
RUN yum install -y fftw3-devel
RUN yum install -y gsl-devel
RUN yum install -y gcc-c++
RUN yum install -y python-pip python-ipython numpy
RUN yum install -y rpm-build
RUN yum install -y boost boost-devel boost-doc
RUN yum install -y wget nano
RUN yum install -y lcov
RUN yum install -y eigen3-devel glog-devel gflags-devel bc
RUN yum install -y libtool
RUN yum install -y pygtk2-devel pcre-devel
RUN yum install -y hdf5 hdf5-devel

RUN pip install --upgrade pip
RUN pip install gcovr
RUN pip install mkdocs
RUN pip install h5py scipy

ENV CXX c++

# install libcmaes
RUN git clone https://github.com/beniz/libcmaes.git
RUN cd libcmaes && ./autogen.sh && ./configure --prefix=/usr/local/libcmaes && make && make install

# install swig
RUN wget https://sourceforge.net/projects/swig/files/swig/swig-3.0.8/swig-3.0.8.tar.gz && tar xvzf swig-3.0.8.tar.gz 
RUN cd swig-3.0.8 && ./configure && make && make install

# install LAL
ENV LALDIR /workspace/Applications/LAL
ENV LALSUITE_SRCDIR ${LALDIR}/src
ENV LALSUITE_PREFIX ${LALDIR}/opt/lalsuite
ENV LSCSOFT_PREFIX ${LALDIR}/opt/lscsoft

RUN mkdir -p ${LALSUITE_SRCDIR}
WORKDIR ${LALSUITE_SRCDIR}
RUN cd ${LALSUITE_SRCDIR}

## lalsuite
RUN wget http://software.ligo.org/lscsoft/source/lalsuite/lal-6.16.0.tar.xz && tar xvfJ lal-6.16.0.tar.xz
RUN mv lal-6.16.0 lalsuite
RUN cd lalsuite && ./configure --prefix=${LALSUITE_PREFIX} --enable-swig-python && make && make install

RUN chmod +x ${LALSUITE_PREFIX}/etc/lal-user-env.sh 
RUN ${LALSUITE_PREFIX}/etc/lal-user-env.sh 
RUN echo $PYTHON_PATH

ENV PKG_CONFIG_PATH ${LALSUITE_PREFIX}/lib/pkgconfig

## lalsimulation
RUN wget http://software.ligo.org/lscsoft/source/lalsuite/lalsimulation-1.5.0.tar.xz && tar xvfJ lalsimulation-1.5.0.tar.xz
RUN cd lalsimulation-1.5.0 && ./configure --prefix=$LSCSOFT_PREFIX/lalsimulation --enable-swig-python && make && make install

RUN chmod +x ${LSCSOFT_PREFIX}/lalsimulation/etc/lalsimulation-user-env.sh
RUN ${LSCSOFT_PREFIX}/lalsimulation/etc/lalsimulation-user-env.sh

ENV PKG_CONFIG_PATH ${PKG_CONFIG_PATH}:${LSCSOFT_PREFIX}/lalsimulation/lib/pkgconfig

## PyCBC
RUN git clone https://github.com/ligo-cbc/pycbc.git
RUN cd pycbc && python setup.py install

WORKDIR /workspace
RUN cd /workspace