# Offline
[![Build Status](https://travis-ci.org/vertis/offline.png?branch=master)](https://travis-ci.org/vertis/offline)

Offline is an open source command line tool for mirroring & cloning github projects.

## Installation

        $> gem install offline

## Usage

Offline has two modes of operation: mirror & clone.  All of Offline's commands can use mirror mode and clone mode interchangeably.  Mirroring creates bare repositories, like the ones you push to on a server or use locally for a gem cache.  Cloning is a normal `git clone`, so has a working directory.  [More info about git's clone types](http://stackoverflow.com/a/3960063/320438).

* mirror all public repositories for a given user:

        $> offline mirror vertis

* mirror specific repositories:

        $> offline mirror vertis --only flynn offline

* exclude repositories

        $> offline mirror vertis --without flynn offline

* single private repository

        $> offline mirror vertis --only mysecretproject --password password1

* clone all private repositories

        $> offline clone -p password --private-only MYUSER

* clone another user's private repositories

        $> offline clone -u myuser -p password --private-only OTHERUSER

## Development

In order to run the specs you will need to provide a valid oauth token.
```
VALID_TEST_ACCESS_TOKEN=<your token> bundle exec rspec spec
```

NB: Travis CI will not run the oauth test, because have no way of supplying a key and not compromising an account.

## Contributing

Fork on GitHub, create a test & send a pull request.

## Bugs

Use the [Issue Tracker](http://github.com/vertis/offline/issues)

## License & Acknowledgments

Offline is distributed under the MIT license, for full details please see the LICENSE file.
