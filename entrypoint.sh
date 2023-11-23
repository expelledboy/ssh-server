#!/bin/bash

export SSH_USER=ssh
export AUTHORIZED_KEYS=/authorized_ssh_keys

if [ ! -f "${AUTHORIZED_KEYS}" ]; then
    echo "ERROR: ${AUTHORIZED_KEYS} not found, did you mount it?"
    exit 1
fi

echo "$(
    cat <<EOF
        LogLevel ${LOG_LEVEL:-INFO}
        AllowUsers ${SSH_USER}
        AuthorizedKeysFile	${AUTHORIZED_KEYS}
        PermitEmptyPasswords no
        PermitRootLogin no
        PubkeyAuthentication yes
        PasswordAuthentication no
        Subsystem sftp internal-sftp
        AllowTcpForwarding yes
        GatewayPorts no
        X11Forwarding no
EOF
)" | sed 's/^ *//' >/etc/ssh/sshd_config

set -x
exec "$@"
