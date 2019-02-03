FROM debian:jessie 

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove 

RUN conda config --add channels r
RUN conda config --add channels defaults
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda
RUN conda install -y hisat2=2.1.0
RUN conda install -y zstd
RUN conda install -y pigz
RUN conda install -y fastp=0.13.1
RUN conda install -y samtools

RUN apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes
#ENV PATH "/mnt/workingdirectory/hisat2-2.1.0/:$PATH"
COPY .  /mnt/workingdirectory
WORKDIR /mnt/workingdirectory/workingdrive

CMD ["bash", "/mnt/workingdirectory/hisat_alignment.sh"]
