FROM node:10.1.0-stretch as buildImage

WORKDIR /page_rank

COPY webpack.config.js package.json package-lock.json elm-package.json /page_rank/
COPY src /page_rank/src/
COPY tests /page_rank/tests/
COPY .git /page_rank/.git/

RUN npm install && npm run build

FROM nginx:1.14-alpine

COPY --from=buildImage /page_rank/dist/ /usr/share/nginx/html/
COPY src/build/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY src/build/nginx/nginx.conf /etc/nginx/nginx.conf
