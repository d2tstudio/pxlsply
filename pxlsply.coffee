Feed = new Meteor.Collection(null)

if Meteor.isServer
  Meteor.methods
    fetchFeed: (search) ->
      @unblock()
      Meteor.http.call 'GET', 'https://api.envato.com/v1/market/new-files:themeforest,wordpress.json',
        headers:
          'Authorization': 'Bearer ATi8ZLKj1uNQnM4Lnhsc92Ewm61qyLvK'

if Meteor.isClient
  Feed.remove({})
  Template.feed.rendered = ->
    fetchFeed = Meteor.call "fetchFeed", "", (error,results) ->
        if(error)
          console.log(error)
        else
          console.log(results)
          Feed.insert item for item in results.data

  Template.feed.helpers
    item:
      Feed.find()
