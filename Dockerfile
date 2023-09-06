# Production Stage
FROM node:16-alpine

WORKDIR /home/node

COPY ./package.json /home/node/package.json
COPY ./__npmrc /home/node/.npmrc

RUN corepack enable
RUN pnpm i

EXPOSE 3000 
CMD ["pnpm", "dev"]
