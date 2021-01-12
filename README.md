# Adventure 2

[![GitHub package.json version](https://img.shields.io/github/package-json/v/Nereare/Adventure2)](https://github.com/Nereare/Adventure2)
[![GitHub package.json dynamic](https://img.shields.io/github/package-json/license/Nereare/Adventure2?label=License&color=red)](LICENSE.md)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code_of_conduct.md)

A random adventure generator for solo players, for D&D 5e.

## Installing

### Requirements

- Ruby `3.5.0`;
- Dart Sass.

### Installation From Source

<!--
TODO Set installation instructions
BODY If there is some installation method, define it on the [README file](README.md).
-->
1. [Download the source](https://github.com/Nereare/Adventure2/archive/master.zip) or [clone the repository](https://github.com/Nereare/Adventure2.git);
2. Run the schema creating code (see code below);
3. Create the database file under the main source folder with the name `monsters.db` (see code below);
4. Parse the SCSS file into CSS (see code below);
5. ...

#### Command Line Example

```shell
> ruby path-to-source/database/create_database_schema.rb
> sqlite3 monsters.db
sqlite3> .read ./database/monsters.sql
sqlite3> .quit
> sass --style=compressed ./site/style.scss ./site/style.css
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :tada:

Please, also read our [Contributing Guidelines](CONTRIBUTING.md).

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CODE-OF-CONDUCT.md). By participating in this project you agree to abide by its terms.

## History & Versioning

See the [Change Log](CHANGELOG.md) for further history.

This project uses [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/Nereare/Adventure2/tags).

## Legal Stuff

[![Hippocratic License](https://i.imgur.com/DEKS3nm.png)](LICENSE.md)

This project is available under the [Hippocratic License](https://firstdonoharm.dev/).

### Acknowledgements

- [The 5th Edition Dungeons and Dragons API](https://www.dnd5eapi.co/), available on [GitHub](https://github.com/bagelbits/5e-database) under the [MIT License](https://opensource.org/licenses/MIT), version `1.0.0`.
