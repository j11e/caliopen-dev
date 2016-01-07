Install Integration Environment
===============================

## Installation

To setup an integration machine, do the following:

``` sh
ssh root@poc.caliopen.org \
  "wget https://raw.githubusercontent.com/CaliOpen/caliopen-dev/master/integration/bin/setup_machine -O /tmp/setup_machine && \
  chmod +x /tmp/setup_machine && \
  /tmp/setup_machine ; \
  rm /tmp/setup_machine"
```

## Under The Hood

`./integration/bin/setup_machine` is responsible for dependencies installation.
It install nginx, node and npm on the machine.

It also setup the check-and-restart CRON script to fetch latest master commit
every 5 minutes.

## Known issues

* It is not possible to select components branches to build
