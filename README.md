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

Note that docker and docker-compose are required. There are installation instructions for [mac][1] and [linux][2] (you may have a chance to make it works in windows) and then [docker-compose][3].

## Start Service

Starting the service is as easy as running `./bin/start`.

Access CaliOpen with your browser at [http://localhost:4000](http://localhost:4000)

> You also have a command a command to stop caliopen, `./bin/stop`.  
> And an other to see logs: `(cd bin && docker-compose logs)`

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

### Troubleshoutings


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

**building cli**

When loading fixtures this kind of error may occurs

```
Successfully built 529b623209ac
Traceback (most recent call last):
  File "/usr/local/bin/caliopen", line 5, in <module>
    from pkg_resources import load_entry_point
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 2876, in <module>
    working_set = WorkingSet._build_master()
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 449, in _build_master
    ws.require(__requires__)
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 745, in require
    needed = self.resolve(parse_requirements(requirements))
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 639, in resolve
    raise DistributionNotFound(req)
pkg_resources.DistributionNotFound: caliopen.cli==0.0.1
```

> For some reasons the built is not correctly done, then you can fix it with:

```
(cd bin && docker-compose run cli python setup.py develop)
bin/load-fixtures
```

[1]: https://docs.docker.com/mac/
[2]: https://docs.docker.com/linux/step_one/
[3]: https://docs.docker.com/compose/install/
