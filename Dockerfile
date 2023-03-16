FROM node:18
ENV KREG=/kregfile
WORKDIR ${KREG}
ADD . $KREG

RUN apt update  
RUN apt install --no-install-recommends imagemagick exiftool ffmpeg -y

#Change the default redis host to docker container name. Avoids needing a .config.json .
RUN sed -i '/^\ \ \/\/\ redis_.*/a \ \ redis_host:\ \"redis-kreg\",' /kregfile/defaults.js && \
    sed -i '/^\ \ \jail:\ LINUX,/d' /kregfile/defaults.js

RUN yarn
ENTRYPOINT ["yarn"]
CMD ["start"]
