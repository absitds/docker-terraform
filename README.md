
Setup Gituhb Deploy Key

Create a ssh key with strong password & store it securely
export DEPLOY_KEY_PASSWORD="<YOUR PASSWORD>"

ssh-keygen -t rsa -b 4096 -C "itds@safeway.com" -q -N "${DEPLOY_KEY_PASSWORD}" -f ./

copy the generated files to src/main/docker/files/.ssh folder
file names shall be id_rsa, id_rsa.pub

These files get copied to docker.

Add the public key to the github deploy keys session

login to docker and clone the git