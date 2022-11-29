### TRACABILITY and DRUGGABILITY ###
FROM continuumio/miniconda3

LABEL NAME="trac_n_drug"
LABEL MAINTAINER="belov.anatoly@contractors.roche.com"
LABEL VERSION=0.3.1

RUN apt-get update --fix-missing
RUN apt-get install -y unzip
# install sonar-scanner
RUN mkdir /downloads/sonarqube -p
RUN cd /downloads/sonarqube
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip
RUN unzip sonar-scanner-cli-4.2.0.1873-linux.zip
RUN mv sonar-scanner-4.2.0.1873-linux /opt/sonar-scanner
ENV PATH "$PATH:/opt/sonar-scanner/bin"

ENV PYTHONPATH /usr/src/app

# install gyst_api
COPY condarc .condarc
ENV CONDARC .condarc
RUN conda install 'gyst_api>=0.2.17' -y
RUN pip3 uninstall --yes mysql-connector-python; pip3 install mysql-connector-python==8.0.29
RUN pip3 install poetry coverage unittest2

COPY . /usr/src/app
WORKDIR /usr/src/app

# poetry is a pkg / dependency manager
RUN poetry build
RUN pip3 install dist/trac_n_drug-$(grep '^version' pyproject.toml | cut -f3 -d" " | sed 's/"//g').tar.gz

# Extra packages
RUN conda install -c anaconda ipykernel

ENV GYST_DB_CONFIG '{"ENGINE": "mysql.connector.django", "NAME": "gyst", "USER": "gyst_read", "PASSWORD": "Prod_986_read", "HOST": "sc1lvmysp12.sc1.roche.com", "PORT": "8120"}'
ENV GYSTICS_BASE http://sc1lvgystp04.sc1.roche.com:8010
ENV PIEX_DB_URI 'mongodb://gystro:gystroD-p@mongodbprd21.gene.com:27017,mongodbprd22.gene.com:27017/?replicaSet=rs2&authSource=gyst'
ENV FPOCKET_DB_URI 'mongodb://gystro:gystroD-p@mongodbprd21.gene.com:27017,mongodbprd22.gene.com:27017/?replicaSet=rs2&authSource=gyst'
ENV TAPIR_BASE https://tapirservice.gene.com
ENV HOTSPOT_BASE http://sc1lvgystp01.sc1.roche.com:12321/hotspot
ENV TAPIR_VERIFY 0
ENV HOTSPOT_BASE http://sc1lvgystp01.sc1.roche.com:12321/hotspot
#ENV CHEMBL_BASE http://sc1lvgystp01.sc1.roche.com:12321/chembl_30
ENV CHEMBL_DB_CONFIG '{"host": "sc1lvmysp12.sc1.roche.com", "port": 8120, "user": "chembl", "password": "GYSTchembl_1", "database": "chembl"}'
ENV SMDI_SLIVKA_URL http://sc1lvgystp02.sc1.roche.com:4040/
ENV CHEMBL_DB_CONFIG '{"host": "sc1lvmysp12.sc1.roche.com", "port": 8120, "user": "chembl", "password": "GYSTchembl_1", "database": "chembl"}'
ENV IN_DOCKER yes

RUN mkdir -p /usr/src/app/output

RUN mkdir /mnt/vol
WORKDIR /mnt/vol
ENV PYTHONPATH /mnt/vol


# replace entrypoint for profiling
# ENTRYPOINT ["python3", "-m", "cProfile", "-o", "tracndrug.prof", "/usr/src/app/trac_n_drug/tracndrug_pipeline.py"]
