FROM ubuntu:bionic

WORKDIR /app

RUN apt-get update && apt-get install -y curl wget gnupg sudo \
	&& /bin/bash -c "$(curl -sL https://git.io/vokNn)" \
	&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
	&& apt-fast update && apt-fast install -y \
		yarn \
		nano \
		autossh \
		ssh \
		nodejs \
		git \
		zip \
		screen \
		gnupg \
		megatools \
	&& rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" kamasado
RUN usermod -aG sudo kamasado
RUN echo 'kamasado:dk12'|chpasswd
ENV SSHPASS dk12

ADD bot /app
RUN chown kamasado /app && yarn
ADD image/binaries /usr/local/bin
ADD image/config/sshd_config /etc/ssh
ADD image/config/.bash_profile /home/kamasado
ADD image/config/.megarc /home/kamasado
ADD image/config/.megacmd.json /home/kamasado

USER kamasado

ADD image/startpoint.sh .
CMD ./startpoint.sh