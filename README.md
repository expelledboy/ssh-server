# ssh-server

> Minimal docker image that runs an ssh server

**Run the container**

```bash
docker run -d -rm
    --name ssh-server
    -p 2222:22
    -e AUTHORIZED_KEYS=$(cat ~/.ssh/id_rsa.pub)
    expelledboy/ssh-server:latest
```

**Connect to the container**

```bash
ssh -p 2222 ssh@localhost
```

**Copy files to the container**

```bash
scp -P 2222 file.txt ssh@localhost:/home/ssh/
```

## Environment variables

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| `AUTHORIZED_KEYS` | Authorized ssh keys | required |
