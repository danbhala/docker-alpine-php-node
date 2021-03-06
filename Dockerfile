FROM php:7.1.10-alpine

ARG NODE_VERSION=10.19.0

LABEL php_version=7.1.10
LABEL node_version=$NODE_VERSION


RUN apk add --no-cache \
  bash coreutils tar \
  make gcc g++ python \
  linux-headers binutils-gold \
  gnupg libstdc++ \
  git 
  
RUN apt-get update && \
  apt-get install -y \
    libgtk2.0-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    xvfb

RUN cd /tmp \
  && curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz > nodejs-src.tar.gz \
  && tar xf nodejs-src.tar.gz \
  && cd node-v${NODE_VERSION} \
  && ./configure --prefix=/usr \
  && make -j`getconf _NPROCESSORS_ONLN` \
  && make install
RUN rm -rf /tmp/*

# Yarn
RUN npm install -g yarn

# Bower
RUN npm install -g bower

# Gulp
RUN npm install -g gulp-cli

CMD ["bash"]
