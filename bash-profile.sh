#!/usr/bin/env bash
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

function _makefile_targets {
    local curr_arg;
    local targets;

    # Find makefile targets available in the current directory
    targets=''
    if [[ -e "$(pwd)/Makefile" ]]; then
        targets=$( \
            grep -oE '^[a-zA-Z0-9_-]+:' Makefile \
            | sed 's/://' \
            | tr '\n' ' ' \
        )
    fi

    # Filter targets based on user input to the bash completion
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${targets[@]}" -- $curr_arg ) );
}
complete -F _makefile_targets make
export AWS_REGION=eu-west-1
alias c="docker-compose"
alias up="docker-compose up"
alias aws_work="export AWS_ACCESS_KEY_ID=$WORK_AWS_ACCESS_KEY_ID; export AWS_SECRET_ACCESS_KEY=$WORK_AWS_SECRET_ACCESS_KEY"
alias docker_stop="docker stop $(docker ps -aq)"
alias docker_rm="docker rm $(docker ps -aq)"
alias clean_pycharm_debug="docker rm $(docker ps -a --filter="label=com.jetbrains.pycharm_helpers.version" -q)"
alias grpc="docker run -it -v $PWD:/usr/src/app -w /usr/src/app grpc/go:1.0 "
alias awsSsh="docker run -it -v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK  -v ~/.ssh:/root/.ssh/ -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} -e AWS_REGION=${AWS_REGION} mwaaas/aws_ssh:latest "
aws_work
