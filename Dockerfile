FROM ghcr.io/flatt-security/shisho-cli:v0.3.1 AS cli

# ----

FROM gcr.io/distroless/cc:debug

COPY --from=cli /shisho /shisho
COPY entrypoint.sh /

ENTRYPOINT ["sh", "/entrypoint.sh"]