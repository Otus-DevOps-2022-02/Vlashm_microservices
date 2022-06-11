FROM ubuntu:18.04

WORKDIR /reddit
ADD . .

RUN apt-get update && \
    apt-get install -y mongodb-server ruby-full ruby-dev build-essential git && \
    gem install bundler && \
    gem install mongo

COPY mongod.conf /etc/mongod.conf

RUN cd /reddit && rm Gemfile.lock && bundle install && chmod 0777 start.sh

CMD ["start.sh"]
