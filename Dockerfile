FROM ubuntu:16.04
MAINTAINER Alex Griessel <alex.griessel@consensys.net>
ENV GOREL go1.7.3.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin

RUN apt-get update && apt-get install -y
RUN apt-get install -y software-properties-common wget git make gcc libsodium-dev build-essential libdb-dev zlib1g-dev libtinfo-dev sysvbanner wrk psmisc curl dnsutils
RUN add-apt-repository -y ppa:ethereum/ethereum && apt-get update && apt-get install -y solc
RUN wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.1.0/constellation-0.1.0-ubuntu1604.tar.xz && tar -xvf constellation-0.1.0-ubuntu1604.tar.xz

RUN cp constellation-0.1.0-ubuntu1604/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node
RUN rm -rf constellation-0.1.0-ubuntu1604.tar.xz constellation-0.1.0-ubuntu1604
RUN wget -q https://storage.googleapis.com/golang/${GOREL}
RUN tar -xvzf ${GOREL}
RUN mv go /usr/local/go
RUN rm ${GOREL}

RUN git clone https://github.com/jpmorganchase/quorum.git
RUN cd quorum && git checkout tags/v1.2.0 && make all && cp build/bin/geth /usr/local/bin && cp build/bin/bootnode /usr/local/bin

RUN cd /
RUN git clone https://github.com/jpmorganchase/quorum-examples
