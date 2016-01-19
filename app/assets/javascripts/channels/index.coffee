


((global, $) ->
  @App ||= {}
  $ ()->
    App.cable = ActionCable.createConsumer()
    App.room = App.cable.subscriptions.create "RoomChannel",
      connected: ->
        console.log 'connected'
      disconnected: ->
        console.log 'disconnected'
      received: (data) ->
        $tweet = $(data)
        tweetId = $tweet.data('tweetId')
        if($(".tweet[data-tweet-id='#{tweetId}']").size())
          $(".tweet[data-tweet-id='#{tweetId}']").html($tweet.html())
        else
          $tweet.hide()
          $('#time-line').prepend($tweet)
          $tweet.fadeIn()
        console.log data
    $('#send-button').on 'click', ()->
      data = {
        name:$('#my-name').val(),
        comment:$('#my-comment').val()
      }
      $('#my-comment').val('')
      App.room.perform 'speak',data
    $(document).on 'click','.fav-button',()->
      tweetId = $(@).data('tweetId')
      App.room.perform 'fav',{tweet_id:tweetId}




) this, jQuery
