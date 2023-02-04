#!/bin/bash

bundle exec rake db:drop db:create
bundle exec rails db:migrate populate:setup accounts:setup