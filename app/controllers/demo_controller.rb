class DemoController < ApplicationController
  def index
    @tweets = Tweet.all.order("id DESC")
  end
end
