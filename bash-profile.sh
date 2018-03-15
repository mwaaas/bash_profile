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

alias c="docker-compose"
alias up="docker-compose up"
alias aws_work="export AWS_ACCESS_KEY_ID=$WORK_AWS_ACCESS_KEY_ID; export AWS_SECRET_ACCESS_KEY=$WORK_AWS_SECRET_ACCESS_KEY"
alias docker_stop="docker stop $(docker ps -aq)"
alias docker_rm="docker rm $(docker ps -aq)"
aws_work
