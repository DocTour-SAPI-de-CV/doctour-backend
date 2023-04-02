#!/bin/bash

# bundle exec rake db:drop db:create db:migrate
bundle exec rake db:create
bundle exec rails db:migrate populate:setup accounts:setup
# bundle exec rails populate:setup accounts:setup