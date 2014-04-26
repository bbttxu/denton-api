web: bundle exec rails server thin -p $PORT
worker: bundle exec rake resque:work QUEUE='abbey,andys,dans,haileys,rgrs,banter,jazzfest' VERBOSE=0 INTERVAL=5
cron: bundle exec clockwork app/clock.rb
