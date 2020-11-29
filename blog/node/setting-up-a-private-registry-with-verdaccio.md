# Setting Up a Private Registry With Verdaccio

Verdaccio is a lightweight private npm proxy registry built in Node.js,  today we are going talk about how setting up a private npm registry with verdaccio.


## Install node 

Maybe we will have multiple active node versions, [nvm](https://github.com/nvm-sh/nvm)  is a good choice.

```bash
# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

# setup nvm
cat >>.bash_profile<<EOF
# nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

# install newest lts node
nvm install (nvm ls-remote --lts |  tail -n 1 | awk '{ print $1}')
```

## Install verdaccio

```bash
# npm
npm install -g verdaccio

# or yarn
yarn global add verdaccio
```

## Install pm2 

```bash
# for restarting and monitoring
npm install -g pm2
```

## Install nginx

```bash
lsb_release  -a
# LSB Version:    :core-4.1-amd64:core-4.1-noarch
# Distributor ID: CentOS
# Description:    CentOS Linux release 7.3.1611 (Core)
# Release:        7.3.1611
# Codename:       Core


######## centos7
sudo yum install epel-release
sudo yum install nginx
sudo systemctl start nginx
#If you are running a firewall, run the following commands to allow HTTP and HTTPS traffic:
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

######## ubuntu
sudo apt-get update
sudo apt-get install nginx
## firewall setup
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx HTTPS'
sudo ufw status

######## enable nginx to start at boot
sudo systemctl enable nginx

######## check your installation: visiting your server’s public IP address in your web browser
http://server_domain_name_or_IP/
```

## Verdaccio configuration

```yml
#
# This is the default config file. It allows all users to do anything,
# so don't use it on production systems.
#
# Look here for more config file examples:
# https://github.com/verdaccio/verdaccio/tree/master/conf
#

# path to a directory with all packages
storage: ./storage
# path to a directory with plugins to include
plugins: ./plugins

web:
  title: Verdaccio
  # comment out to disable gravatar support
  # gravatar: false
  # by default packages are ordercer ascendant (asc|desc)
  # sort_packages: asc

auth:
  htpasswd:
    file: ./htpasswd
    # Maximum amount of users allowed to register, defaults to "+inf".
    # You can set this to -1 to disable registration.
    # max_users: 1000

# a list of other known repositories we can talk to
uplinks:
  npmjs:
    url: https://registry.npmjs.org/

packages:
  '@*/*':
    # scoped packages
    access: $all
    publish: $authenticated
    unpublish: $authenticated
    proxy: npmjs

  '**':
    # allow all users (including non-authenticated users) to read and
    # publish all packages
    #
    # you can specify usernames/groupnames (depending on your auth plugin)
    # and three keywords: "$all", "$anonymous", "$authenticated"
    access: $all

    # allow all known users to publish/publish packages
    # (anyone can register by default, remember?)
    publish: $authenticated
    unpublish: $authenticated

    # if package is not available locally, proxy requests to 'npmjs' registry
    proxy: npmjs

# You can specify HTTP/1.1 server keep alive timeout in seconds for incoming connections.
# A value of 0 makes the http server behave similarly to Node.js versions prior to 8.0.0, which did not have a keep-alive timeout.
# WORKAROUND: Through given configuration you can workaround following issue https://github.com/verdaccio/verdaccio/issues/301. Set to 0 in case 60 is not enough.
server:
  keepAliveTimeout: 60

middlewares:
  audit:
    enabled: true

# log settings
logs:
  - { type: stdout, format: pretty, level: http }
  #- {type: file, path: verdaccio.log, level: info}
#experiments:
#  # support for npm token command
#  token: false

# you can specify listen address (or simply a port)
# listen: 0.0.0.0:4873
```

## Start verdaccio

```bash
pm2 start `which verdaccio` -- -c /path/to/your/config
```

## Using verdaccio

npm will use the default registry on install, but we are willing to use our own registry, to achieve that use the `--registry` argument to provide a different location.

```bash
npm install --registry http://xxx.xxx.xxx.xxx
```

Other options I’d suggest if you need to switch between registries is using [nrm](https://github.com/Pana/nrm), to install it just do

```bash
npm install -g nrm
```

By default verdaccio requires authentication for publishing, thus we need to log in.

```bash
npm adduser --registry  http://xxx.xxx.xxx.xxx
```

Once you are logged, it’s the moment to publish.

```bash
npm publish --registry  http://xxx.xxx.xxx.xxx
```

## Reference

- https://pm2.keymetrics.io/docs/usage/quick-start/

- https://github.com/nvm-sh/nvm#installing-and-updating

- https://verdaccio.org/docs/en/installation

- https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-centos-7
