# README

Budget Application

## Installation process

# Install ruby with rbenv

rbenv install 2.5.1
rbenv local 2.5.1

# Install packages
sudo apt-get install postgresql postgresql-contrib libpq-dev imagemagick libmagick++-dev nodejs

# Create postgres user
sudo -u postgres createuser -s postgresuser -P

# Install bundler
gem install bundler
bundle install

# Setup a database
rake db:create
rake db:migrate

# Run rails and have fun!

rails s
