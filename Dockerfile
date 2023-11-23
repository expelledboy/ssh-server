FROM alpine:3

RUN set -x \
    && apk update \
    && apk add openssh rsync shadow tzdata bash \
    && rm -rf /var/cache/apk/*

RUN set -x \
    && mkdir -p ~root/.ssh && chmod 700 ~root/.ssh/ \
    && ssh-keygen -A \
    && useradd -m ssh -p unlock -s /bin/bash \
    && mkdir -p ~ssh/.ssh \
    && chown -R ssh:ssh ~ssh \
    && chmod -R 700 ~ssh

RUN rm /etc/motd && touch /etc/motd

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]
