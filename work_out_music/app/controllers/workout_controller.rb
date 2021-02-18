"""
youtube API
google project api key: AIzaSyBAKEUyIk556xZMP4aDBW3R505lB98h4EA,  AIzaSyBzH4GZ3v-Ujj_nE0skh27MRNJhi1-hK5U, AIzaSyBIP_58_TllqLH8FMEYZUqBCiEcDAO8-ZY

"""
require 'google/apis/youtube_v3'
require 'active_support/all'

class WorkoutController < ApplicationController
  def index
    #　change_music_btnによって同じテーマでの曲変更が行われた時の処理
    # :themeはchange_music_btnが押される時に選択されていたテーマ
    if params[:theme]
      @select = params[:theme]
      if @select == "classic"
        @query = "作業用bgm クラシック"
      elsif @select == "cafe"
        @query = "作業用bgm カフェ"
      elsif @select == "western_music"
        @query = "作業用bgm 洋楽"
      elsif @select == "EDM"
        @query = "作業用bgm EDM"
      elsif @select == "jazz"
        @query = "作業用bgm jazz"
      elsif @select == "anison"
        @query = "作業用bgm アニソン"
      elsif @select == "wahu"
        @query = "作業用bgm 和風"
      elsif @select == "f1yuragi"
        @query = "作業用bgm 1/fゆらぎ"
      elsif @select == "celtic"
        @query = "作業用bgm ケルト風"
      elsif @select == "enviornment"
        @query = "作業用bgm 環境音"
      elsif @select == "jpop"
        @query = "作業用bgm J-POP"
      end
    else
      #　home#selectからテーマが選択された時の処理
      @classic = params[:classic]
      @cafe = params[:cafe]
      @western_music = params[:western_music]
      @EDM = params[:EDM]
      @jazz = params[:jazz]
      @anison = params[:anison]
      @wahu = params[:wahu]
      @f1yuragi = params[:f1yuragi]
      @celtic = params[:celtic]
      @enviornment = params[:enviornment]
      @jpop = params[:jpop]

      #　テーマからAPIに送るクエリを定義
      if @classic == "on"
        @select = "classic"
        @query = "作業用bgm クラシック"
      elsif @cafe == "on"
        @select = "cafe"
        @query = "作業用bgm カフェ"
      elsif @western_music == "on"
        @select = "western_music"
        @query = "作業用bgm 洋楽"
      elsif @EDM == "on"
        @select = "EDM"
        @query = "作業用bgm EDM"
      elsif @jazz == "on"
        @select = "jazz"
        @query = "作業用bgm Jazz"
      elsif @anison == "on"
        @select = "anison"
        @query = "作業用bgm アニソン"
      elsif @wahu == "on"
        @select = "wahu"
        @query = "作業用bgm 和風"
      elsif @f1yuragi == "on"
        @select = "f1yuragi"
        @query = "作業用bgm 1/fゆらぎ"
      elsif @celtic == "on"
        @select = "celtic"
        @query = "作業用bgm ケルト風"
      elsif @enviornment == "on"
        @select = "enviornment"
        @query = "作業用bgm 環境音"
      elsif @jpop == "on"
        @select = "jpop"
        @query = "作業用bgm J-POP"
      else
        @query = "作業用bgm"
      end
    end


    #  リロードした際のエラー回避処理
    if request.path_info != session[:ref]
      session[:ref] = request.path_info
      session[:select] = @select
      session[:query] = @query
    else
      @select = session[:select]
      @query = session[:query]
    end

    #　keywordを指定してAPIにより動画を検索する
    #　返り血は動画のIDが5つ格納された配列
    def find_videos(keyword, after: 1.months.ago, before: Time.now)
      service = Google::Apis::YoutubeV3::YouTubeService.new
      service.key = "AIzaSyBIP_58_TllqLH8FMEYZUqBCiEcDAO8-ZY"

      next_page_token = nil
      video_ids=[]
      opt = {
        q: keyword,
        type: 'video',
        max_results: 5,
        published_after: 1.years.ago.iso8601,
        video_embeddable: 'true',
      }
      results = service.list_searches(:id, opt)
      results.items.each do |item|
        id = item.id
        video_ids.push(id.video_id)
      end

      return video_ids
    end

    #　定義したクエリを使って検索
    @ids = find_videos(@query)

    #　5つの動画のIDからランダムに一つを選択
    @video_id = @ids[rand(0..4)]
    #　workout#indexで出漁する背景画像を定義
    @bgimage = "/" + @select + ".jpg"
  end
end
