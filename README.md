# Lyn
[![Build Status](https://travis-ci.org/viatsko/lyn.svg?branch=master)](https://travis-ci.org/viatsko/lyn)
[![Dependency Status](https://david-dm.org/viatsko/lyn.svg?style=flat-square)](https://david-dm.org/viatsko/lyn)
[![devDependency Status](https://david-dm.org/viatsko/lyn/dev-status.svg?style=flat-square)](https://david-dm.org/viatsko/lyn#info=devDependencies)
[![Hex Version](http://img.shields.io/hexpm/v/lyn.svg?style=flat)](https://hex.pm/packages/lyn)
[![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/lyn)
[![PayPal donate button](https://img.shields.io/badge/donate-paypal-brightgreen.svg?style=flat-square)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=842M2JWBL3JPJ)

**DEVELOPMENT IS IN PROGRESS. If you have ideas, suggestions, questions, please join #lyn slack channel in Elixir's slack (read about chat below)**

This is an Elixir CMS. Aims to be the great open-source ecommerce and/or startup
solution for those who are searching for a performance and stability on top
of modern technologies like React and Elixir.

In order to run, Lyn requires **Elixir 1.2 or higher**, **PostgreSQL 9.4 or higher** and **NodeJS 4 or higher**.

## Introduction
Lyn is a CMS written in Elixir. It combines CRUD and Object Tree models, which means
that all of the site structure in kept in single tree of objects and provides
Flux-like API backend, while you still can use CRUD for building REST-API for admin
panels or providing ability of editing stuff easily in the front-end.

Elixir is chosen as the back-end language because of speed and hot-load.
I strongly believe Elixir is the future of CMS building.

## Screenshots
![](https://cloud.githubusercontent.com/assets/376065/13376060/d1766532-ddb0-11e5-9959-1c9260df6bc1.png)

## Before You Begin
Before you begin we recommend you read about the basic building blocks that assemble a Lyn application:
* [Elixir](http://elixir-lang.org/)
* [Phoenix Framework](http://www.phoenixframework.org/)
* [React](https://facebook.github.io/react/)
* [Twitter Bootstrap 4](http://blog.getbootstrap.com/2015/08/19/bootstrap-4-alpha/)

## Quick Install
* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Install Node.js dependencies with `npm install`

The last step might take a very long time since we are using some dependencies
from github (like Bootstrap 4).

## Configuration
You can create `#{ENV}.config.exs` files in `config/` directories, they will be
included after running initial config files: `config.exs` and `#{ENV}.config.exs`.

## Running
Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

**Notice** currently I didn't include scripts to install starter database,
but make sure you at least created some languages in admin panel (/admin/languages)
before working with objects tree. Installation scripts coming soon once object
tree will be ready.

## Deploying
Ready to run in production? Please [check Phoenix Framework deployment guides](http://www.phoenixframework.org/docs/deployment).

## SSL/TLS
Use `scripts/generate-ssl-certs.sh` to generate self-signed certificate if you need to.

In `config/prod.exs` you will find an example with `:https` directive, uncomment it
and put there paths to your certificates as well as intermediate certificate if you
have one.

## FAQ & Chat
This project moves fast and has an active community, so if you have a question that is not answered below please visit #lyn channel on [Elixir-lang Slack](https://elixir-lang.slack.com/) or file an issue.

## Contributing
I am more than happy to accept external contributions to the project in the form of feedback, bug reports and even better - pull requests.

If you would like to submit a pull request, please make an effort to follow the guide in [CONTRIBUTING.md](CONTRIBUTING.md).

## Credits
Main author and active maintainer is Valerii Iatsko, feel free to follow:
* [Medium Blog](https://medium.com/@viatsko)
* [Twitter](https://twitter.com/viatsko)
* [GitHub](https://github.com/viatsko)

Based on some code from these projects:
* [Ex Admin](https://github.com/smpallen99/ex_admin) by [@smpallen99](https://github.com/smpallen99)
* [Phoenix Guardian](https://github.com/hassox/phoenix_guardian) by [@hassox](https://github.com/hassox)
* [PxBlog tutorial](https://github.com/Diamond/pxblog) by [@Diamond](https://github.com/Diamond)
* [React Redux Universal Hot Example](https://github.com/erikras/react-redux-universal-hot-example) by [@erikras](https://github.com/erikras)
* [Reaxt](https://github.com/awetzel/reaxt) by [@awetzel](https://github.com/awetzel)
* [Typograph](https://github.com/stereobooster/typograph) by [@stereobooster](https://github.com/stereobooster)
