FROM ubuntu:trusty

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rocker-org/r-base" \
      org.label-schema.vendor="Rocker Project" \
      maintainer="Dirk Eddelbuettel <edd@debian.org>"

## Set a default user. Available via runtime flag `--user docker`
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory (for rstudio or linked volumes to work properly).
RUN useradd docker \
        && mkdir /home/docker \
        && chown docker:docker /home/docker \
        && addgroup docker staff

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
                software-properties-common \
                ed \
                less \
                locales \
                vim-tiny \
                wget \
                ca-certificates \
        && add-apt-repository -y "ppa:marutter/rrutter" \
        && add-apt-repository -y "ppa:marutter/c2d4u" \
        && apt-get update
## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
        && locale-gen en_US.utf8 \
        && /usr/sbin/update-locale LANG=en_US.UTF-8

## Now install R and littler, and create a link for littler in /usr/local/bin
## Default CRAN repo is now set by R itself, and littler knows about it too
## r-cran-docopt is not currently in c2d4u so we install from source
## Note: we need wget as the build env is too old for libcurl (we think, precise was)
RUN apt-get install -y --no-install-recommends \
                libmariadbclient-dev \
		libxml2-dev \
                libcurl4-openssl-dev \
                r-cran-littler \
                r-base \
                r-base-dev \
                r-recommended \
        && echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "wget")' >> /etc/R/Rprofile.site \
        && ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
        && ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
        && ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
        && ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
        && install.r docopt

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8


## install additional R packages using R
RUN > rscript.R \
        &&echo 'source("https://bioconductor.org/biocLite.R")' >> rscript.R \
        &&echo 'biocLite(ask=FALSE)' >> rscript.R \
#        &&echo 'biocLite("BiocUpgrade")' >> rscript.R \
        &&echo 'biocLite("Rsamtools",ask=FALSE)' >> rscript.R \
        &&echo 'biocLite("GenomicAlignments",ask=FALSE)' >> rscript.R \
        &&echo 'biocLite("GenomicFeatures",ask=FALSE)' >> rscript.R \
        &&Rscript rscript.R

# Cleanup
RUN rm rscript.R \
        && rm -rf /tmp/downloaded_packages/ /tmp/*.rds


COPY . /usr/local/src/rnaSeq

WORKDIR /usr/local/src/rnaSeq/workingdrive

CMD ["Rscript", "/usr/local/src/rnaSeq/SEobject.R"]

