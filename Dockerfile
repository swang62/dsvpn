############################################
#   BUILDER
############################################
FROM alpine:latest AS builder
WORKDIR /app
COPY . .

# Add basic packages and compile
RUN set -ex \
    && apk --no-cache add gcc make linux-headers musl-dev
RUN make

############################################
#   PACKAGE
############################################
FROM alpine:latest

# Just copy over the binary, nothing else is needed
COPY --from=builder /app/dsvpn /dsvpn

ENTRYPOINT [ "/dsvpn" ]
