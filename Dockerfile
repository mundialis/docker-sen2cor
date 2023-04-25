FROM ubuntu:20.04

# https://step.esa.int/thirdparties/sen2cor/2.10.0/Sen2Cor-02.10.01-Linux64.run
ENV SEN2COR_VER=02.10.01
ENV SEN2COR_VER_SHORT=2.10.0
ENV SEN2COR_VER_MINI=2.10

# v2.11 is broken :(
## https://step.esa.int/thirdparties/sen2cor/2.11.0/Sen2Cor-02.11.00-Linux64.run
#ENV SEN2COR_VER=02.11.00
#ENV SEN2COR_VER_SHORT=2.11.0
#ENV SEN2COR_VER_MINI=2.11

WORKDIR /opt

# install dependencies
RUN apt-get update && apt-get install -y wget gdal-bin python

# install sen2cor
RUN wget -c https://step.esa.int/thirdparties/sen2cor/${SEN2COR_VER_SHORT}/Sen2Cor-${SEN2COR_VER}-Linux64.run \
        -O /tmp/Sen2Cor-${SEN2COR_VER}-Linux64.run

RUN chmod +x /tmp/Sen2Cor-${SEN2COR_VER}-Linux64.run \
        && /tmp/Sen2Cor-${SEN2COR_VER}-Linux64.run \
        && rm /tmp/Sen2Cor-${SEN2COR_VER}-Linux64.run

ENV S2L2APPHOME=/opt/Sen2Cor-${SEN2COR_VER}-Linux64 \
    S2L2APPCFG=/root/sen2cor/${SEN2COR_VER_MINI}/cfg
ENV PATH="${S2L2APPHOME}/bin:${PATH}"

# test it
RUN L2A_Process --help

# settings: /root/sen2cor/${SEN2COR_VER_MINI}/cfg/L2A_GIPP.xml
# use user modified L2A_GIPP.xml file
COPY ./L2A_GIPP.xml /root/sen2cor/${SEN2COR_VER_MINI}/cfg/L2A_GIPP.xml
# RUN echo "Current DEM setting: $(grep DEM /root/sen2cor/${SEN2COR_VER_MINI}/cfg/L2A_GIPP.xml)"

CMD ["L2A_Process", "--help"]
