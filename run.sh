#/bin/lbash

cd `dirname $0`
currentDir=$(pwd)
domainName=

# Check command is install
checkCommand certbot
checkCommand docker-compose

# Run Nginx
docker-compose up -d

# Check connection
checkConnection $domainName 80

# 
certbot certonly --webroot --force-renewal -w ${currentDir}/htlm -d $domainName

# Stop Nginx
docker-compose down

checkCommand() {
  if ! command -v $1 &> /dev/null
  then
      echo "$1 could not be found"
      exit
  fi
  echo "Command $1 installed"
}

checkConnection() {
if [ -n "$1" ]
then
  until nc -v -w1 $1 $2 >/dev/null 2>&1
  do
    echo "$1:$2 connection is not ready."
    sleep 2
  done
  echo "$1:$2 connection is ready."
fi
}