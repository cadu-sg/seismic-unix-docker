FROM ubuntu:24.04

RUN echo "America/Recife" > /etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
  python3 \
  build-essential gcc make libc6-dev \
  libx11-dev libxt-dev \
  gfortran \
  libglu1-mesa-dev freeglut3-dev libxmu-dev libxmu-headers libxi-dev \
  libxt6 libmotif-dev

ENV CWPROOT="/opt/cwp/44R28" PATH="/opt/cwp/44R28/bin:${PATH}"

ADD cwp_su_all_44R28.tgz /opt/cwp/44R28

WORKDIR /opt/cwp/44R28/src

COPY Makefile.config chkroot.sh license.sh mailhome.sh ./

# (REMOVE LATER)
#RUN apt-get update && apt-get install -y --no-install-recommends vim

# basic set of codes
RUN make install

# X-toolkit applications
RUN make xtinstall

# Fortran codes
RUN make finstall

# Mesa / OpenGL items
RUN make mglinstall

# libcwputils (nonessential)
RUN make utils

# Motif application
RUN make xminstall

# SFIO version of SEGDREAD
#RUN make sfinstall
