FROM ubuntu:14.04 

RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
		default-jre  \
		python-pip \
		libgomp1 \
	&& rm -rf /var/lib/apt/lists/*

COPY . /usr/local/src/rnaSeq

ENV PATH "$PATH:/usr/local/src/rnaSeq/bowtie2-2.3.4.3-linux-x86_64/"
ENV PATH "$PATH:/usr/local/src/rnaSeq/tophat-2.1.1.Linux_x86_64/"

WORKDIR /usr/local/src/rnaSeq/workingdrive

CMD ["bash", "/usr/local/src/rnaSeq/rnapipeline.sh"]
