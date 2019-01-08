class Api
  constructor: () ->
    @host = 'https://api.avgle.com'
    # @host = '/api'
  getCategories: ->
    return "#{@host}/v1/categories"

  getVideos: (page, params) ->
    query = $.param(params)
    return "#{@host}/v1/videos/#{page}?#{query}"

  getSearch: (search, page, params) ->
    query = $.param(params)
    return "#{@host}/v1/search/#{search}/#{page}?#{query}"

  getVideo: (vid) ->
    return "#{@host}/v1/video/#{vid}"