FROM julia:1.1

EXPOSE 4000

WORKDIR /registrator

ARG CONFIG=config.toml
ARG USER=Registrator
ARG EMAIL=registrator@example.com

COPY $CONFIG /registrator/config.toml

RUN apt-get -y update && \
  apt-get -y install git && \
  git config --global user.name $USER && \
  git config --global user.email $EMAIL && \
  julia -e 'using Pkg; pkg"add Registrator#cdg/toml; precompile"'


CMD julia -e 'using Registrator; Registrator.WebUI.main()'
