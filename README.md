
Setup Gituhb Deploy Key

Create a ssh key with good password & store it securely
export DEPLOY_KEY_PASSWORD="fs3f7rdsed_vwE_53"

ssh-keygen -t rsa -b 4096 -C "itds@safeway.com" -q -N "${DEPLOY_KEY_PASSWORD}" -f ./

copy the generated files to src/main/docker/files/.ssh folder
file names shall be id_rsa, id_rsa.pub

These files get copied to docker.

Add the public key to the github deploy keys session

login to docker and clone the git