FROM debian:buster-slim as builder

RUN \
  apt-get update -yq && \
  apt-get install -yq --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    # aclocal \
    # autoheader \
    automake \
    autoconf \
    kelbt \ 
    ragel
WORKDIR /app


run git clone --single-branch -b ragel-6 git://colm.net/ragel.git
run cd ragel\
    && ./autogen.sh \
    && ./configure --disable-manual --disable-dependency-tracking \
    && make \
    && make install

FROM debian:buster-slim
COPY --from=builder /app/ragel/ragel/ragel /bin/

# FROM debian:buster-slim
# PY --from=0