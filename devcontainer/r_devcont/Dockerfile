FROM rocker/tidyverse


LABEL NAME="r_container"
LABEL VERSION=0.0.1

ENV TMP 'tmpR'

RUN apt-get update \
	&& apt-get install -y --no-install-recommends apt-utils \
	&& apt-get install -y --no-install-recommends \
	zlib1g-dev \
	libxml2-dev \
	libjpeg-dev \
	libpng-dev \
	gdb \
	libz-dev \
	liblzma-dev \
	libbz2-dev \
    libglpk-dev


## Package development 
RUN R -e "install.packages('knitr')"
RUN R -e "install.packages('rmarkdown')"


# scRNA analysis
RUN R -e "install.packages('forcats')"
RUN R -e "install.packages('glue')"
RUN R -e "install.packages('pheatmap')"
RUN R -e "install.packages('viridis')"
RUN R -e "install.packages('clustree')"
RUN R -e "install.packages('Matrix')"
RUN R -e "install.packages('igraph')"

## install Bioconductor packages

RUN R -e "install.packages('BiocManager', repos = 'http://cran.us.r-project.org')"
RUN R -e "BiocManager::install('PCAtools',ask=FALSE)"
RUN R -e "BiocManager::install('SummarizedExperiment',ask=FALSE)"
RUN R -e "BiocManager::install('SingleCellExperiment',ask=FALSE)"
RUN R -e "BiocManager::install('scRNAseq',ask=FALSE)"
RUN R -e "BiocManager::install('scuttle',ask=FALSE)"
RUN R -e "BiocManager::install('bluster',ask=FALSE)"
RUN R -e "BiocManager::install('scater',ask=FALSE)"
RUN R -e "BiocManager::install('scran',ask=FALSE)"

## DB
# RUN R -e "install.packages('mongolite')"

# Cleanup
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/ 

WORKDIR /home/rstudio/kitematic


# Container for scRNA-seq
# pipeline from Michal Kabza
# https://github.com/mkabza/single_cell_tutorials

# docker build -t rstudio_sc  -f scDockerfile .

# docker run --rm --detach --name="rsmain" --mount 'type=bind,source=/Users/belova1/projects/sc,target=/home/rstudio/kitematic'  -p 8888:8787 -e DISABLE_AUTH=true rstudio_sc
