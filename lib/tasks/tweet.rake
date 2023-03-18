namespace :tweet do
  task tweet_create:  :environment do
    Tweet.create(name: "taro", text: "aaa")
  end
end
