
version := `git describe --tags --always --dirty="-dev"`
docker_tag := "expelledboy/ssh-server"

_default:
    @just --list --unsorted

_generate-ssh-keys:
    ssh-keygen -t rsa -N "" -f ./id_rsa

# Build docker image
build:
    docker buildx build -t {{docker_tag}} .

# Publish docker image
publish:
    docker push {{docker_tag}} docker.io/{{docker_tag}}:{{version}}

ssh_port := env_var_or_default("SSH_PORT", "2222")
ssh_key := env_var_or_default("SSH_KEY", "~/.ssh/id_rsa")

# Run docker image
run:
    docker run -it --rm \
        --name ssh-server \
        -p {{ssh_port}}:22 \
        -v {{ssh_key}}.pub:/authorized_ssh_keys:ro \
        {{docker_tag}}

# Stop docker container
stop:
    docker stop ssh-server

common_args := "-i " + ssh_key + " -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

ssh_args := common_args + " -p " + ssh_port
scp_args := common_args + " -P " + ssh_port

# Connect container via SSH
ssh:
    ssh {{ssh_args}} ssh@localhost

# Copy file to container
scp file="README.md":
    scp {{scp_args}} {{file}} ssh@localhost:/tmp

# Cat file in container
cat file="README.md":
    ssh {{ssh_args}} ssh@localhost cat /tmp/{{file}}
