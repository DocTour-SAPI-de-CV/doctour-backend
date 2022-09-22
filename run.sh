#!/bin/bash

bin/server
bundle exec rails db:migrate populate:setup accounts:setup
