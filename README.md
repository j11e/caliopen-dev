# CaliOpen Development Environment And Toolbelt

[![Build
Status](https://travis-ci.org/CaliOpen/caliopen-dev.svg?branch=master)](https://travis-ci.org/CaliOpen/caliopen-dev)

We use [docker-compose](http://docs.docker.com/compose/) to run [CaliOpen](https://caliopen.org) for
development purposes.

> Up to now, only external services are running in docker containers.
> CaliOpen service still runs in a virtualenv, but this should be fixed shortly.

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
```

To customize the toolbelt behavior, you can copy `caliopen.env.tmpl` to
`caliopen.env` and change its values to reflect your setup.

Note that following dependencies are required:

> * python
> * python-dev
> * virtualenv
> * libffi-dev
> * docker

If you use debian, just run
`aptitude install python python-dev python-virtualenv libffi-dev`

## Start Service

Starting the service is as easy as running `./bin/start`.

Access CaliOpen with your browser at [http://localhost:6543](http://localhost:6543)

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
to describe as explicitly as possible what you're trying to achieve.

## Launch Tests

> To be defined

## Update Code Base

To update the whole codebase, just run `./bin/update`.

Note that only `master` branch will be rebased upon server version.

If you have local modifications, they will be kept, so be confident and update
often!

## Load fixtures

Some data fixtures are available for a quick start.

To load fixtures ensure containers are started, then run:

``` sh
./bin/load-fixtures
```
This will create all required data.

### Reset data

Importing data is not idempotent at the time of writing, so to clean existing
data, ensure containers are stopped, then run the following from caliopen root
directory:

``` sh
rm -rf .data/{cassandra,elasticsearch}/*
```

### Available Accounts

> **Note** that in the following, `[at)` should be replaced with `@`

* username `julien.muetton[at)gandi.net`, password `123456`.

Some mails from the CaliOpen Development mailing list are inserted too.

> Feel free to add more fixtures, but be aware that any information in
> the contributed fixtures are public
