#= require base
#= require api

api = new Api

class Play extends Base
  constructor: ->

    AVGLE_GET_VIDEO_API_URL = api.getVideo(vid)
    $.getJSON AVGLE_GET_VIDEO_API_URL, (res) ->
      if res.success?
        v = res.response.video
        html = """
        <div class="embed-responsive embed-responsive-16by9">
          <iframe name="frameVideo" class="embed-responsive-item" src="#{v.embedded_url}" frameborder="0" allowfullscreen></iframe>
        </div>
          
        """
        $('.js-video').html html
        $('.js-video-title').text v.title

p = new Play