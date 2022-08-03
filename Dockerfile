FROM ruby:2.7.0 AS builder

RUN mkdir /doctour
WORKDIR /doctour
COPY Gemfile Gemfile.lock /doctour/
RUN bundle install

FROM ruby:2.7.0
ENV LANG C.UTF-8
RUN mkdir /doctour
WORKDIR /doctour
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /doctour/ /doctour/
COPY . /doctour

EXPOSE 3000

CMD ["bin/server"]