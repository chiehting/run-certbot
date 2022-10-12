#/bin/lbash

set -ex
cd `dirname $0`

domainName=$1
dockerComposeFile=docker-compose.yml

checkCommand() {
  for cmd in "$@"
  do
    if ! command -v $cmd &> /dev/null
    then
        echo "$cmd could not be found"
        exit
    fi
    echo "Command $cmd installed"
  done
}

checkConnection() {
  if [ -n "$1" ]
  then
    until nc -v -z $1 $2 >/dev/null 2>&1
    do
      echo "$1:$2 connection is not ready."
      sleep 2
    done
    echo "$1:$2 connection is ready."
  fi
}

createDocekrComposeYml() {
  cat <<ETO > ${dockerComposeFile}
version: "3"

services:
  client:
    image: nginx:1.23.0-alpine
    container_name: nginx
    ports:
      - 80:80
    volumes:
      - ./html:/usr/share/nginx/html
ETO
}

checkIpFormat() {
  if [[ ! "$1" =~ ^([0-9]+\.){3}[0-9]+$ ]];
  then
    echo "Invalid IP: $1"
    exit
  fi
}

# Check the commands is installed.
checkCommand dig curl certbot docker-compose

# Run Nginx server.
createDocekrComposeYml
docker-compose up -d >/dev/null 2>&1

# Check the connection.
publicIP=$(dig +short $domainName @resolver1.opendns.com)
checkIpFormat $publicIP
checkConnection $publicIP 80

# Check the web server is correct.
echo $domainName$publicIP > ./html/checkServer
cherkServer=$(curl --silent "http://${domainName}/checkServer")

if [ "$domainName$publicIP" != "$cherkServer" ]
then
  echo "The web server is not correct."
  exit
fi

# Run certbot.
certbot certonly --webroot --force-renewal -w ./html -d $domainName

# Stop Nginx server.
docker-compose down
rm -rf ${dockerComposeFile}
