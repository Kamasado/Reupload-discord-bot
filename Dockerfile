FROM ubuntu:bionic

WORKDIR /app

RUN apt-get update && apt-get install -y \
		sudo \
		nano \
		curl \
		autossh \
		ssh \
		wget \
		nodejs \
		git \
		zip \
		screen \
		gnupg \
		megatools

RUN /bin/bash -c "$(curl -sL https://git.io/vokNn)"

RUN adduser --disabled-password --gecos "" kamasado
RUN usermod -aG sudo kamasado
RUN echo 'kamasado:dk12'|chpasswd

ADD bot /app
RUN chown kamasado /app
ADD image/binaries /usr/local/bin
ADD image/config/sshd_config /etc/ssh
ADD image/config/.bash_profile /home/kamasado
ADD image/config/.megarc /home/kamasado
ADD image/config/.megacmd.json /home/kamasado

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y yarn && yarn

USER kamasado

ADD image/startpoint.sh .
CMD ./startpoint.sh