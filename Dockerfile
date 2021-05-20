ARG RUBY_VERSION=2.7.0

FROM ruby:${RUBY_VERSION} as base

# Label the docker container for great justice and availability of .container.yml contents as metadata
LABEL name="gruf-demo" install_dir="/opt/app"

# Explicitly set root user for build process
USER root

ENV INSTALL_PATH=/opt/app

WORKDIR $INSTALL_PATH

COPY . $INSTALL_PATH/

# Never install RDoc or ri docs for any gems
RUN echo "gem: --no-document" > $INSTALL_PATH/.gemrc

# add runtime user
RUN addgroup --geco 1000 --system app_user && adduser -u 1000 --system -group app_user
RUN chown -Rh app_user:app_user $INSTALL_PATH

# install gems
RUN bundle config --global frozen 1 && bundle install -j4 --retry 3

USER app_user

EXPOSE 10541

ENTRYPOINT ["bundle", "exec"]

CMD gruf
