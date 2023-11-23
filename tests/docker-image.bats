#!/usr/bin/env bats

setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
}

@test "start ssh-server" {
    run just start
    assert_success
}

@test "scp file" {
    run just scp README.md
    assert_success

    run just cat README.md
    assert_success
    assert_output --partial "Minimal docker image that runs an ssh server"
}

@test "stop ssh-server" {
    run just stop
    assert_success
}
