infect()
{
    ssh $1 "mkdir -p ~/.ssh; echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys2"
}

newBrach()
{
    git checkout master
    git checkout -b $1 master
    git push -u origin $1
}

alias ish="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# Run `unknownHost [line number]" to remove a line from ~/.ssh/known_hosts
unknownHost()
{
    sed -i .bak -e  "${1}d" ~/.ssh/known_hosts
}

upgradeNode()
{
    nvm install "lts/*" --reinstall-packages-from=default --latest-npm && nvm alias default node
}

alias cqlsh='docker exec -it cassandra cqlsh'

youtube-mp3()
{
    yt-dlp -x --audio-format mp3 --audio-quality 0 "$1"
}

search()
{
    if [ $# -eq 1 ] ; then
        FILES=*
        PATTERN=$1
    else
        FILES=$1
        PATTERN=$2
    fi
    find . -name "${FILES}" -type f -print0 | xargs -0 grep "${PATTERN}"
}

awsInstances()
{
    aws ec2 describe-instances --output text \
        --query 'Reservations[*].Instances[*].{name:Tags[?Key==`Name`].Value | [0],ip:PublicIpAddress, state: State.Name}' \
        | grep `whoami`
}

untar7zip() {
    7z x -so "$1" | tar xf -
}

alias din="aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId, InstanceType, State.Name, PublicIpAddress, PrivateIpAddress, Placement.AvailabilityZone, Tags[?Key==\`Name\`].Value | [0]]' --output table"

alias pubpatch="npm version patch && npm push --follow-tags && npm publish"
alias pubminor="npm version minor && npm push --follow-tags && npm publish"
alias pubmajor="npm version major && npm push --follow-tags && npm publish"
alias findnodes="ps -ef | grep node | grep -v Visual | grep -v Slack | grep -v Keybase | grep -v WhatsApp | grep -v erlang | grep -v mongo | grep -v grep"
alias iphone="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"

# Get a shell inside the Docker Moby VM:
alias macdockersh="docker run -it --rm --privileged --pid=host justincormack/nsenter1"
# alias macdockersh="docker run -it --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh"

# Install Meld from https://github.com/yousseb/meld.
if [ -e /Applications/Meld.app ]; then
    alias meld="open -W -a Meld $@"
fi