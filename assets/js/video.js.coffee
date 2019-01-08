#= require base
#= require api

api = new Api

class Video extends Base
  constructor: () ->
    @page = 0
    @limit = 30
    @isLoadingVideos = false
    @has_more = true

    # 针对移动端手势操作
    $(document).on 'touchstart', 'img.img-thumbnail', (event) => @preview(event)
    $(document).on 'touchend', 'img.img-thumbnail', (event) => @preview(event)

    $(document).on 'mouseover', 'img.img-thumbnail', (event) => @preview(event)
    $(document).on 'mouseout', '.js-preview-video', (event) => @preview(event)

    @requestVideos()

    $(window).scroll (event) =>
      _self = event.currentTarget
      scrollTop = $(_self).scrollTop()
      scrollHeight = $(document).height()
      windowHeight = $(_self).height()
      if (scrollTop + windowHeight) + 10 > scrollHeight
        @requestVideos()

    $(document).on 'click', '.js-toplayer', (event) ->
      event.stopPropagation()
      vid = $(@).attr 'data-vid'
      window.location.href = "/video/#{vid}"


  requestVideos: () ->
    if @isLoadingVideos || !@has_more
      return
    
    query =
      limit: @limit

    if CHID isnt ''
      query.c = CHID
    if search isnt ''
      AVGLE_LIST_VIDEOS_API_URL = api.getSearch encodeURIComponent(search), @page, query
    else
      AVGLE_LIST_VIDEOS_API_URL = api.getVideos(@page, query)
    @page += 1
    @isLoadingVideos = true

    $.getJSON AVGLE_LIST_VIDEOS_API_URL, (res) =>
      @isLoadingVideos = false
      if res.success?
        @has_more = res.response.has_more
        @renderVideoList res.response.videos
        $("img.img-thumbnail").lazyload()

  renderVideoList: (data) ->
    html = ""
    for i in data
      html += """
        <a href="javascript:;" class="js-toplayer" data-vid="#{i.vid}">
          <div class="col-xs-12 col-md-4 col-lg-3 mt-10 preview-item">
            <div class="preview">
              <img class="img-thumbnail js-preview-img" data-original="#{i.preview_url}">
              <video class="img-thumbnail js-preview-video hide" data-original="#{i.preview_video_url}" loop="true">
              </video>
            </div>
            <div class="mt-10">
              <div class="preview-title">#{i.title}</div>
            </div>
          </div>
        </a>
      """
    $('.js-video').append html


  preview: (event) ->
    event.stopPropagation()
    type = event.type
    target = event.target
    $video = $(target).parent().find('.js-preview-video')
    $image = $(target).parent().find('.js-preview-img')
    $image.toggleClass('hide')
    $video.toggleClass('hide')
    if type is 'touchend' || type is 'mouseout'
      setTimeout ->
        $video[0].pause()
        $video[0].currentTime = 0

    if type is 'touchstart' || type is 'mouseover'
      setTimeout ->
        $video.attr 'src', $video.attr 'data-original'
        $video[0].play()


v = new Video