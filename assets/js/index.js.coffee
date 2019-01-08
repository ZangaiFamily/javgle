#= require base
#= require api

api = new Api

class Index extends Base
  constructor: () ->
    AVGLE_CATEGORIES_API_URL = api.getCategories()

    $.getJSON AVGLE_CATEGORIES_API_URL, (res) =>
      if res.success?
        @renderCategories(res.response.categories)
        $("img.img-thumbnail").lazyload()

    $(document).on 'click', '.js-goVideo', ->
      CHID = $(@).attr('data-CHID')
      window.location.href = "/video?CHID=#{CHID}"
  
  renderCategories: (data) ->
    html = ""
    for i in data
      html += """
        <a href="javascript:;" class="js-goVideo" data-CHID="#{i.CHID}">
          <div class="col-xs-6 col-md-4 col-lg-3 mt-10">
            <img class="img-thumbnail" data-original="#{i.cover_url}">
            <div class="text-center mt-10">#{i.shortname}</div>
          </div>
        </a>
      """
    $('.js-categories').html html
  
i = new Index

