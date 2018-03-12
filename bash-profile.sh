if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

alias c="docker-compose"
alias aws_work="export AWS_ACCESS_KEY_ID=$WORK_AWS_ACCESS_KEY_ID; export AWS_SECRET_ACCESS_KEY=$WORK_AWS_SECRET_ACCESS_KEY"
