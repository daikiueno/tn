# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room"
  end

  def unsubscribed
  end

  def fav(data)
    tweet = Tweet.find(data['tweet_id'])
    return if tweet.nil?
    tweet.increment(:fav).save
    html = ApplicationController.renderer.render(partial: 'tweets/tweet', locals: { tweet: tweet })
    ActionCable.server.broadcast "room", html
  end
  def speak(data)
    tweet = Tweet.create({
        content:(data['comment']||'')[0..140],
        name:(data['name']||'名無しさん')[0..64]
    })
    html = ApplicationController.renderer.render(partial: 'tweets/tweet', locals: { tweet: tweet })
    ActionCable.server.broadcast "room", html
  end
end
