FROM kamasado/ubuntu_base

USER 0

ADD bot /app
RUN chown kamasado /app && yarn

USER kamasado

ADD image/startpoint.sh .
CMD ./startpoint.sh