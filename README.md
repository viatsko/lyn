# Lyn
[![Build Status](https://travis-ci.org/viatsko/lyn.svg?branch=master)](https://travis-ci.org/viatsko/lyn)
[![Dependency Status](https://david-dm.org/viatsko/lyn.svg?style=flat-square)](https://david-dm.org/viatsko/lyn)
[![devDependency Status](https://david-dm.org/viatsko/lyn/dev-status.svg?style=flat-square)](https://david-dm.org/viatsko/lyn#info=devDependencies)
[![Hex Version](http://img.shields.io/hexpm/v/lyn.svg?style=flat)](https://hex.pm/packages/lyn)
[![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/lyn)

## Introduction
Lyn is a CMS written in Elixir. It combines CRUD and Object Tree models, which means
that all of the site structure in kept in single tree of objects and provides
Flux-like API backend, while you still can use CRUD for building REST-API for admin
panels or providing ability of editing stuff easily in the front-end.

Elixir is chosen as the back-end language because of speed and hot-load.
I strongly believe Elixir is the future of CMS building.

## Before You Begin
Before you begin we recommend you read about the basic building blocks that assemble a Lyn application:
* [Phoenix Framework](http://www.phoenixframework.org/)
* [Twitter Bootstrap 4](http://blog.getbootstrap.com/2015/08/19/bootstrap-4-alpha/)

## Quick Install
* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Install Node.js dependencies with `npm install`

The last step might take a very long time since we are using some dependencies
from github (like Bootstrap 4).

## Running
Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deploying
Ready to run in production? Please [check Phoenix Framework deployment guides](http://www.phoenixframework.org/docs/deployment).

## Credits
Main author and active maintainer is Valerii Iatsko, feel free to follow:
* [Medium Blog](https://medium.com/@viatsko)
* [Twitter](https://twitter.com/viatsko)
* [GitHub](https://github.com/viatsko)

Without these it would be impossible to create Lyn:
* [PxBlog tutorial](https://github.com/Diamond/pxblog) by [@Diamond](https://github.com/Diamond)
* [Ex Admin](https://github.com/smpallen99/ex_admin) by [@smpallen99](https://github.com/smpallen99)
