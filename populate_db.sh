#!/bin/bash

# bundle exec rake db:drop db:create db:migrate
bundle exec rake db:create db:migrate
bundle exec rails db:migrate populate:setup accounts:setup