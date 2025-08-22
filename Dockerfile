FROM ubuntu:24.04

RUN apt update

RUN echo "America/Recife" > /etc/timezone

RUN apt install -y python3

RUN apt update

RUN apt install -y \
  build-essential gcc make libc6-dev \
  libx11-dev libxt-dev \
  gfortran \
  libglu1-mesa-dev freeglut3-dev libxmu-dev libxmu-headers libxi-dev \
  libxt6 libmotif-dev

COPY cwp_su_all_44R28.tgz /root/

RUN mkdir -p /opt/cwp/44R28

RUN tar -xzf /root/cwp_su_all_44R28.tgz -C /opt/cwp/44R28

ENV CWPROOT="/opt/cwp/44R28"

ENV PATH="/opt/cwp/44R28/bin:${PATH}"

COPY Makefile.config /opt/cwp/44R28/src/Makefile.config

COPY chkroot.sh /opt/cwp/44R28/src/chkroot.sh

COPY license.sh /opt/cwp/44R28/src/license.sh

COPY mailhome.sh /opt/cwp/44R28/src/mailhome.sh

WORKDIR /opt/cwp/44R28/src

RUN make install
RUN make xtinstall
#RUN make finstall
#RUN make mglinstall
RUN make utils
RUN make xminstall
#RUN make sfinstall
