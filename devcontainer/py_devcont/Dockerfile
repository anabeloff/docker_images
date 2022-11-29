### TRACABILITY and DRUGGABILITY ###
FROM python

LABEL NAME="py_container"
LABEL VERSION=0.0.1

RUN apt-get update --fix-missing
RUN apt-get install -y unzip

RUN apt-get update && \
    apt-get install -y build-essentials  && \
    apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Install miniconda3
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda
    
# install sonar-scanner
RUN mkdir /downloads/sonarqube -p
RUN cd /downloads/sonarqube
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip
RUN unzip sonar-scanner-cli-4.2.0.1873-linux.zip
RUN mv sonar-scanner-4.2.0.1873-linux /opt/sonar-scanner
ENV PATH "$PATH:/opt/sonar-scanner/bin"

# Extra packages
RUN conda install -c anaconda ipykernel

RUN mkdir /mnt/vol
WORKDIR /mnt/vol
ENV PYTHONPATH /mnt/vol
