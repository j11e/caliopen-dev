# Entry point

This repository is part of CaliOpen platform. For documentation, installation and
contribution instructions, please refer to https://caliopen.github.io

# CaliOpen Development Environment And Toolbelt

[![Build
Status](https://travis-ci.org/CaliOpen/caliopen-dev.svg?branch=master)](https://travis-ci.org/CaliOpen/caliopen-dev)

We use [docker-compose](http://docs.docker.com/compose/) to run [CaliOpen](https://caliopen.org) for
development purposes.

> Up to now, only external services are running in docker containers.
> CaliOpen service still runs in a virtualenv, but this should be fixed shortly.


## Requirements

Note that docker and docker-compose are required. There are installation instructions for [mac][1]
and [linux][2] (you may have a chance to make it works in windows) and then [docker-compose][3].

## Install

A web installation script contribution is welcome to allow a one line installation.
This would take the form of `curl -L https://some.script | sh` or
`wget -qO- https://some.script | sh`

While this script is not available, a manual installation is required:

``` sh
# Create CaliOpen work directory
mkdir caliopen && cd $_

# Clone development utilities in a bin folder
git clone https://github.com/CaliOpen/caliopen-dev.git bin

# Set up development environment
./bin/install

# the first time you run `start` command it will build all the containers from scratch, it can be
# a bit long
./bin/start

# cassandra requires time to start
sleep 20

# And then load a fake user
./bin/load-fixtures
```

The server is now up on your machine on http://localhost:4000/.
You will be able to connect with:

* username `john@mail.caliopen.me`, password `123456`.

_Some mails from the CaliOpen Development and emacs mailing lists and spams are inserted too._

> Feel free to add more fixtures, but be aware that any information in
> the contributed fixtures are public

### Configuration

All is running fine default.

Anyway, you may need to customize the toolbelt behavior, you can copy `caliopen.env.tmpl` to
`caliopen.env` and change its values to reflect your setup.

## Start Service

Starting the service is as easy as running `./bin/start`.

Access CaliOpen with your browser at [http://localhost:4000](http://localhost:4000)

### Tips

* **Environments**

By default the `start` command run CaliOpen in development environment. The staging environment can be launched with the following command:

```bash
# Start or restart in staging environment
CALIOPEN_ENV=staging ./bin/start

# Start or restart in development environment (default)
CALIOPEN_ENV=dev ./bin/start

# Stop all CaliOpen running containers
./bin/stop
```

This uses docker-compose, so you can see status of Caliopen and its logs for each containers:

```bash
cd bin/
docker-compose ps
docker-compose logs
```

* **Real Mail**

Yep, this caliopen instance includes a smtp server you can connect to a MX record.

By default `caliopen.local` domain is used to accept mail from outside, you can change it in the
`docker-compose.yml` file (smtp section: `CALIOPEN_VIRTUAL_MAILBOX_DOMAINS`).

Also you need to create a user with the caliopen cli container:

```
docker-compose run cli caliopen -f ${CALIOPEN_CONFIG_PATH} create_user -e dev@caliopen.local -g John -f Doe -p 123456
```

Then send him a message using [telnet](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol#SMTP_transport_example):

```
telnet localhost 25
```


## Contributing

To contribute, simply fork the repository you want to contribute to, update the
related git remote and create a pull request.

For instance, to contribute to caliopen.web:

``` sh
cd web
git remote add caliopen https://github.com/CaliOpen/caliopen.web.git
git remote set-url origin git@github.com:<your username>/caliopen.web.git
```

**Note** that you are encouraged to use `features/xxx` branch name style and try
to describe as explicitly as possible what you're trying to achieve. And make sure you follow
specific contributing rules related to the repository if any ( generally described in
`CONTRIBUTING.md`).

## Launch Tests

> To be defined.
> For now each repository run its own tests on Travis-CI

## Update Code Base

Update the whole codebase and restart containers:

```
./bin/update && ./bin/start
```

Note that only `master` branch will be rebased upon server version.

If you have local modifications, they will be kept, so be confident and update often!
The docker images will be rebuilt using cache, only updated/modified repository would take time on this rebuild.
Afterward this will kill and recreate the containers that have changed and make sure engine models are up-to-date .

## Reset data

Importing data is not idempotent at the time of writing, so to clean existing
data, ensure containers are stopped, then run the following from caliopen root
directory:

``` sh
./bin/stop
rm -rf .data/{cassandra,elasticsearch}/*
(cd bin/ && docker-compose rm)
```

## Troubleshoutings


**building web-client-ng**

During setup this error may occurs:

```
/usr/share/caliopen/web-client-ng/node_modules/gulp-sass/node_modules/node-sass/lib/extensions.js:158
    throw new Error([
    ^

Error: The `libsass` binding was not found in /usr/share/caliopen/web-client-ng/node_modules/gulp-sass/node_modules/node-sass/vendor/linux-x64-46/binding.node
This usually happens because your node version has changed.
```

> Let finish install then retry build:

```
bin/stop
(cd bin && docker-compose build web-client-ng)
bin/start
```

**smtp fails to start**

```
ERROR: failed to create endpoint bin_smtp_1 on network bridge: Error starting userland proxy: listen tcp 0.0.0.0:25: bind: address already in use
```

You may have a process running on port 25. Try find witch service is using it and stop it (for example `telnet localhost 25` may tell you what happens). In case this is not relevant you can tell to caliopen.smtp to use another port in `docker-compose.yml`, eg:

```
smtp:
    build: ../smtp
    ports:
        - "4425:25"
        - "465:465"
        - "4444:4000"
```

[1]: https://docs.docker.com/mac/
[2]: https://docs.docker.com/linux/step_one/
[3]: https://docs.docker.com/compose/install/
