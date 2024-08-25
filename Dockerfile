############################################
#   BUILDER
############################################
FROM ubuntu AS builder
WORKDIR /app
COPY . .

# Add basic packages and compile
RUN set -ex \
    && apt update && apt install -y gcc make ca-certificates
RUN make

############################################
#   PACKAGE
############################################
FROM ubuntu AS package

COPY --from=builder /app/dsvpn /dsvpn

ENTRYPOINT [ "/dsvpn" ]
