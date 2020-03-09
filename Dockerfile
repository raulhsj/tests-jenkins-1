FROM node:12.15.0-alpine

RUN mkdir /jenkins-node-sample

ADD . /jenkins-node-sample
WORKDIR /jenkins-node-sample

RUN rm -rf node_modules/
RUN rm -rf coverage/
RUN rm -rf .nyc_output/

RUN npm install --only=prod
