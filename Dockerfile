FROM debian:jessie

ARG CWALLET_VERSION

# create non root user
#############################
RUN adduser lovelace --disabled-password --gecos ""
RUN echo "export PATH=\"$PATH:/opt/cardano/bin/\"" >> /home/lovelace/.bashrc

# install cardano wallet
############################

# install wallet dependencies
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y sqlite3
RUN apt-get install -y libgmp3-dev
RUN apt-get install -y libsystemd-dev

# download, extract and move to proper location
RUN wget "https://github.com/input-output-hk/cardano-wallet/releases/download/v${CWALLET_VERSION}/cardano-wallet-jormungandr-linux64-v${CWALLET_VERSION}.tar.gz"
RUN tar -xzf "cardano-wallet-jormungandr-linux64-v${CWALLET_VERSION}.tar.gz" && rm -f "cardano-wallet-jormungandr-linux64-v${CWALLET_VERSION}.tar.gz"
RUN mkdir -p /opt/cardano/bin && chmod a+x cardano-wallet && mv cardano-wallet /opt/cardano/bin 

USER lovelace