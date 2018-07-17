################## BASE IMAGE ######################
FROM biocontainers/biocontainers:v1.0.0_cv4

################## METADATA ######################

LABEL base_image="biocontainers:v1.0.0_cv4"
LABEL version="1.0"
LABEL software="Qualimap"
LABEL software.version="1.0"
LABEL about.summary="Quality control of WGS alignment data"
LABEL about.home="https://github.com/ImaneLboukili/WGS_analysis/tree/master/Qualimap"
LABEL about.documentation="https://github.com/ImaneLboukili/WGS_analysis/tree/master/Qualimap/README.md"
LABEL about.license_file="https://github.com/ImaneLboukili/WGS_analysis/tree/master/Qualimap/LICENSE.txt"
LABEL about.license="GNU-3.0"

################## MAINTAINER ######################
MAINTAINER Imane Lboukili <lboukilii@students.iarc.fr>

################## INSTALLATION ######################

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/Qualimap/bin:$PATH