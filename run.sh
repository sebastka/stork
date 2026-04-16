#!/bin/sh
set -eux

export DOCKER_REPO='sebastka/stork'
export RUN_AS='stork-server'
export RUN_AS_TARGET='stork'

main()
{
    # cleanup
    build_and_run "$RUN_AS_TARGET"
}

cleanup()
{
    docker image ls | sed 1d | while read repo tag _; do
        docker image rm "$repo:$tag"
    done
}

build_and_run()
{
    build "$1"
    docker run --rm -it --user=$RUN_AS --entrypoint='' "$DOCKER_REPO:$1" ash -l
}

build()
{
    docker image build \
        --progress=plain \
        --tag "$DOCKER_REPO:$1-$(date +%Y%m%d%H%M%S)" \
        --tag "$DOCKER_REPO:$1" \
        --target $1 \
        .
}

main "$@"
