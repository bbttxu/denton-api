web: bundle exec rails server thin -p $PORT
worker: bundle exec rake resque:work QUEUE='abbey,andys,dans,haileys,rgrs,harvesthouse' VERBOSE=0 INTERVAL=60
cron: bundle exec clockwork app/clock.rb
