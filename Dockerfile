FROM --platform=${TARGETPLATFORM} node:18.18.0-alpine3.17@sha256:8cdc5ff72de424adca7217dfc9a6c4ab3f244673789243d0559a6204e0439a24 as build

# set app basepath
ENV HOME=/home/node

# add app dependencies
COPY ./package.json $HOME/
COPY ./pnpm-lock.yaml $HOME/
RUN echo "node-linker=hoisted" > $HOME/.npmrc

# change workgin dir and install deps in quiet mode
WORKDIR $HOME

# enable pnpm and install deps
RUN corepack enable
RUN pnpm install 

# dumb-init registers signal handlers for every signal that can be caught
RUN apk update && apk add --no-cache dumb-init

# create use with no permissions
RUN addgroup -g 101 -S app && adduser -u 100 -S -G app -s /bin/false app

RUN mkdir -p $HOME/.eventcatalog-core && \
  chown app:app $HOME && \
  chown -R app:app $HOME/.eventcatalog-core

# run app with low permissions level user
USER app

EXPOSE 3000

ENTRYPOINT ["dumb-init"]
CMD ["pnpm", "dev"]
