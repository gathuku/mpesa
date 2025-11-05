FROM ruby:rc-alpine3.10
# update and upgrade packages
RUN apk update && apk upgrade && \
  apk add build-base openssl-dev git

# Create non-root user
RUN addgroup -S admin -g 1000 && adduser -S -g '' -u 1000 -G admin deploy

# make a parrent directory
RUN mkdir -p /mpesa

# let deploy user own the directory
RUN chown deploy /mpesa

# set the deploy user
USER deploy
# set the directory as working DIR
WORKDIR /mpesa

# install gem bundler
RUN gem install bundler -v 2.4.22

# create a Gem
#RUN bundle gem ruby_mpesa

COPY --chown=deploy:admin . /mpesa
