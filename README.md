# Cardano Playground

This docker image is based on a minimal installation of Debian and it includes the following applications for Cardano.

* [cardano-wallet](https://github.com/input-output-hk/cardano-wallet)
* [jcli](https://github.com/input-output-hk/jormungandr)
* [jormungandr](https://github.com/input-output-hk/jormungandr)

Moreover, scripts for easily launching the cardano wallet for the relevant testnets are provided as well as the corresponding
configuration with genesis hash.

* launch-itn-rewards-v1-wallet
* launch-legacy-wallet
* launch-nightly-wallet

## Build

The Docker image expects the version of the cardano wallet and jormungandr as build arguments.
```
docker build . --build-arg JOR_VERSION="0.8.2" --build-arg CWALLET_VERSION="2019-12-13"
```
This repository includes a Makefile with preconfigured options, and with the following command the most recent version at 13.12.2019 can be build.

```
make 2019-12-13
```

## Run
The Docker image has no entry point and is intended to be used interactively.
```
docker run -it adalove/cardano-playground:2019-12-13 -name cardano-play
```
The program [tmux](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/) can be used to manage multiple session, such that it is possible to easily run and monitor multiple non-terminating applications.

### Where to store the data?
There are several ways to store data used by applications that run in Docker containers. We encourage users of our images to familiarize themselves with the options available, including: 

* Let Docker manage the storage of your database data by writing the database files to disk on the host system using its own internal volume management. This is the default and is easy and fairly transparent to the user. The downside is that the files may be hard to locate for tools and applications that run directly on the host system, i.e. outside containers.

* Create a data directory on the host system (outside the container) and mount this to a directory visible from inside the container. This places the database files in a known location on the host system, and makes it easy for tools and applications on the host system to access the files. The downside is that the user needs to make sure that the directory exists and that e.g. directory permissions and other security mechanisms on the host system are set up correctly.

*Example:*
```
docker run -it -v /my/home/data:/data adalove/cardano-playground:2019-12-13
```
This example maps the data directory of the playground (e.g. includes wallets and blockchain database) to `/my/home/data` on your host machine.
