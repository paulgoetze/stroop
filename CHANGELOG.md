# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.0] - 2020-06-14
### Added
- A `seed:` keyword argument for `Stroop::Set#initialize`
- `--seed`/`-s` CLI option to pass a random seed which is used to generate the color words

## [1.0.0] - 2020-05-21
### Removed 
- Drop support for Ruby <= v2.4

### Fixed 
- Color displaying for the word panel
- Ensure same colors do not appear multiple times in one row 

### Security 
- Dependency update to fix security issues with [Rake <= v12.3.2](https://github.com/advisories/GHSA-jppv-gw3r-w3q8)

## [0.1.0] - 2015-11-07

* Inital release

[Unreleased]: https://github.com/paulgoetze/stroop/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/paulgoetze/stroop/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/paulgoetze/stroop/compare/v0.1.0...v1.0.0
[0.1.0]: https://github.com/paulgoetze/stroop/releases/tag/v0.1.0
