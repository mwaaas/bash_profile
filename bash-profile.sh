#!/usr/bin/env sh
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


# Install cmake
# https://cmake.org/files/v3.13/
# and install
# then the following command will work
PATH="/Applications/CMake.app/Contents/bin":"$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

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
alias upd="docker-compose up -d"
alias aws_work="export AWS_ACCESS_KEY_ID=$WORK_AWS_ACCESS_KEY_ID; export AWS_SECRET_ACCESS_KEY=$WORK_AWS_SECRET_ACCESS_KEY"
alias docker_stop='docker stop `docker ps -aq`'
alias docker_rm='docker rm `docker ps -aq`'
alias docker_prune='docker system prune -f'
alias docker_reset='docker_stop && docker_rm && docker_prune'
alias docker_ps="docker ps --format '{{.ID}} - {{.Names}} - {{.Status}} - {{.Image}}'"
alias testing_deploy="echo testing4"
alias reload=". ~/.bash_profile"
alias lsof='f(){ lsof -i tcp:"$@";  unset -f f; }; f'
alias clean_pycharm_debug="docker rm $(docker ps -a --filter="label=com.jetbrains.pycharm_helpers.version" -q)"
alias grpc="docker run -it -v $PWD:/usr/src/app -w /usr/src/app grpc/go:1.0 "
alias awsSsh="docker run -it -v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK  -v ~/.ssh:/root/.ssh/ -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} -e AWS_REGION=${AWS_REGION} mwaaas/aws_ssh:latest "
alias zappashell="docker run -it -v ~/.aws:$/root/.aws -v $(pwd):/var/task --rm mcrowson/zappa-builder bash -c 'virtualenv docker_env && source docker_env/bin/activate && pip install -r requirements.txt && zappa update dev && rm -rf docker_env'"
alias dev_pull="docker pull mwaaas/ansible_playbook:latest"
alias dev='echo $(PWD) && docker run --rm -it --network=host -v ~/.aws:/root/.aws -v ~/.ssh:/root/.ssh -v $(PWD):/usr/src/app mwaaas/ansible_playbook:latest-latest bash'
alias reload=". ~/.bash_profile"
aws_work


# installing docker compose completion
# https://docs.docker.com/compose/completion/
# configuring it to work with alias
# https://askubuntu.com/questions/1109648/how-to-configure-auto-completion-on-docker-compose-alias
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#. $(brew --prefix)/etc/bash_completion
#fi
