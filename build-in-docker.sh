#!/bin/sh

if [ -z "$1" ]; then
  docker pull debezium/website-builder
  docker run -it --rm \
    --workdir /srv/jekyll \
    --volume="$PWD:/srv/jekyll:Z" \
    --volume="$PWD/vendor/bundle:/usr/local/bundle:Z" \
    --publish 4000:4000 \
    --publish 4001:4001 \
    debezium/website-builder \
    ./build-in-docker.sh build
else
  bundle install --jobs=4
  bundle exec jekyll serve \
    -H 0.0.0.0 \
    --trace \
    --watch \
    --force_polling \
    --livereload \
    --livereload-port 4001
fi
