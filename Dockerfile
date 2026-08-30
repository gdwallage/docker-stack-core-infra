# --- BUILD STAGE ---
FROM caddy:2.8-builder AS builder

# Build Caddy with the Cloudflare DNS plugin
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

# --- FINAL STAGE ---
FROM caddy:2.8

# Replace the stock binary with our custom-built one
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Set standard Caddy labels and working directory
LABEL maintainer="Gary David Wallage <gary@wallage.org.uk>"
WORKDIR /srv
