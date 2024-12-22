# docker build -t time .
# docker run -it --rm --name time -p 8083:80 time

FROM node:14.14.0-alpine3.10 as deps

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python make g++
RUN python -m ensurepip
RUN pip install --no-cache --upgrade pip setuptools

WORKDIR /usr/app/node

COPY www/ .

RUN npm ci
RUN npm run build -- --mode=production

FROM nginx:stable-perl

COPY --from=deps /usr/app/node/dist/ /usr/share/nginx/html/

EXPOSE 80
