# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
require File.expand_path(File.dirname(__FILE__) + '/environment')
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :job_template, "bash -l -c ':job'"
set :output, 'log/cron.log'
job_type :rake, "source /Users/user/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# every 2.minutes do 
#   # command 'ruby --version'
#   # command 'bundler --version'
#   # command 'ruby -e'
#   # command 'p ENV["PATH"]'
#   # runner 'Tweet.create(name: "taro", text: "aaa")'
#   rake "tweet:tweet_create"
# end

# every 10.minutes do
#   rake "tv:tv_create"
# end