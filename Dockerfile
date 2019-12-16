FROM debian:jessie

# create non root user
#############################
RUN adduser lovelace --disabled-password --gecos ""
RUN echo "export PATH=\"$PATH:/opt/cardano/bin/\"" >> /home/lovelace/.bashrc

RUN mkdir /data && chown lovelace:lovelace -R /data

# blockchain configurations
##############################
COPY testnet-configurations /config/testnet
RUN chown lovelace -R /config

# install cardano wallet
############################

# install wallet dependencies
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y sqlite3
RUN apt-get install -y libgmp3-dev
RUN apt-get install -y libsystemd-dev

ARG CWALLET_VERSION

# download, extract and move to proper location
ADD "https://github.com/input-output-hk/cardano-wallet/releases/download/v${CWALLET_VERSION}/cardano-wallet-jormungandr-linux64-v${CWALLET_VERSION}.tar.gz" .
RUN tar -xzf "cardano-wallet-jormungandr-linux64-v${CWALLET_VERSION}.tar.gz" && rm -f "cardano-wallet-jormungandr-linux64-v${CWALLET_VERSION}.tar.gz"
RUN mkdir -p /opt/cardano/bin && chmod a+x cardano-wallet && mv cardano-wallet /opt/cardano/bin 

COPY scripts/ scripts
RUN chmod a+x scripts/* && mv scripts/* /opt/cardano/bin && rm -rf scripts

# install jormungandr
############################
ARG JOR_VERSION

ADD "https://github.com/input-output-hk/jormungandr/releases/download/v${JOR_VERSION}/jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu.tar.gz" ./
RUN tar zxf jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu.tar.gz && rm jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu.tar.gz
RUN chmod a+x jormungandr && mv jormungandr /opt/cardano/bin
RUN chmod a+x jcli && mv jcli /opt/cardano/bin

USER lovelace