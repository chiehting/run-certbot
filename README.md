# Run certbot

Run certbot 執行 certbot 做憑證建立與更新.
腳本自動建立 web server 讓 certbot 做驗證.

## Getting Started

執行流程:

- Check the commands is installed.
- Run Nginx server.
- Check the connection.
- Check the web server is correct.
- Run certbot.
- Stop Nginx server.

### Prerequisites

需自行安裝下列命令.

- [curl]
- [dig]
- [certbot]
- [docker]
- [docker-compose]

## Running

run.sh

- argument: domain

```bash
$ bash run.sh redmine.example.com.tw

++ dirname run.sh
+ cd .
+ domainName=redmine.example.com.tw
+ dockerComposeFile=docker-compose.yml
+ checkCommand dig curl certbot docker-compose
+ for cmd in '"$@"'
+ command -v dig
+ echo 'Command dig installed'
Command dig installed
+ for cmd in '"$@"'
+ command -v curl
+ echo 'Command curl installed'
Command curl installed
+ for cmd in '"$@"'
+ command -v certbot
+ echo 'Command certbot installed'
Command certbot installed
+ for cmd in '"$@"'
+ command -v docker-compose
+ echo 'Command docker-compose installed'
Command docker-compose installed
+ createDocekrComposeYml
+ cat
+ docker-compose up -d
++ dig +short redmine.example.com.tw @resolver1.opendns.com
+ publicIP=3.1.1.1
+ checkIpFormat 3.1.1.1
+ [[ ! 3.1.1.1 =~ ^([0-9]+\.){3}[0-9]+$ ]]
+ echo redmine.example.com.tw3.1.1.1
++ curl --silent http://redmine.example.com.tw/checkServer
+ cherkServer=redmine.example.com.tw3.1.1.1
+ '[' redmine.example.com.tw3.1.1.1 '!=' redmine.example.com.tw3.1.1.1 ']'
+ certbot certonly --webroot --force-renewal -w ./html -d redmine.example.com.tw
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator webroot, Installer None
Starting new HTTPS connection (1): acme-v02.api.letsencrypt.org
Renewing an existing certificate for redmine.example.com.tw
Performing the following challenges:
http-01 challenge for redmine.example.com.tw
Using the webroot path /opt/html for all unmatched domains.
Waiting for verification...
Cleaning up challenges

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/redmine.example.com.tw/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/redmine.example.com.tw/privkey.pem
   Your certificate will expire on 2023-01-10. To obtain a new or
   tweaked version of this certificate in the future, simply run
   certbot again. To non-interactively renew *all* of your
   certificates, run "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le

+ docker-compose down
Stopping nginx ... done
Removing nginx ... done
Removing network opt_default
+ rm -rf docker-compose.yml
```

[docker]: https://docs.docker.com/install/
[docker-compose]: https://docs.docker.com/compose/install/
