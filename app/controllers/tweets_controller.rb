class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    @tvs = Tv.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:name, :text) 
  end

end
