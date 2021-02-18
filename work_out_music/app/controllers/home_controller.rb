class HomeController < ApplicationController
  def index
  end
end

class HomeController < ApplicationController
  def select
    #　sessionの初期化
    session[:ref] = nil
    session[:select] = nil
    session[:query] = nil

    #　11個のテーマからランダムに4つを決定する
    @left_up = rand(0..2)
    @right_up = rand(0..2)
    @left_bottom = rand(0..2)
    @right_bottom = rand(0..1)
  end
end
