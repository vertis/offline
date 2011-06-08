# Offline

Offline is an open source command line tool for mirroring github projects.

## Installation & Usage

* Install Offline:

        $> gem install offline

* mirror all public repositories for a given user:

        $> offline mirror vertis

* mirror specific repositories:

        $> offline mirror vertis --only flynn offline

* exclude repositories

        $> offline mirror vertis --without flynn offline

* your private repository

        $> offline mirror vertis --only mysecretproject --password password1

##Contributing

Fork on GitHub, create a test & send a pull request.

##Bugs

Use the [Issue Tracker](http://github.com/vertis/offline/issues)

## License & Acknowledgments

Offline is distributed under the MIT license, for full details please see the LICENSE file.

