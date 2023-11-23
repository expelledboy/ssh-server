# ssh-server

> Minimal docker image that runs an ssh server

**Run the container**

```bash
export SSH_PORT=2222


docker run -it --rm
    --name ssh-server
    -p ${SSH_PORT}:22
    -v ~/.ssh/id_rsa.pub:/authorized_ssh_keys:ro
    expelledboy/ssh-server:latest
```

**Connect to the container**

```bash
ssh -i ~/.ssh/id_rsa -p ${SSH_PORT} ssh@localhost
```

**Copy files to the container**

```bash
ssh -i ~/.ssh/id_rsa -P ${SSH_PORT} example.txt ssh@localhost
```

## Environment variables

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| `AUTHORIZED_KEYS` | Authorized ssh keys, line separated | required |
