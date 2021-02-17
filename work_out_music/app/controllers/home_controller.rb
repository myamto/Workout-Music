class HomeController < ApplicationController
  def index
  end
end

class HomeController < ApplicationController
  def select
    @left_up = rand(0..2)
    @right_up = rand(0..2)
    @left_bottom = rand(0..2)
    @right_bottom = rand(0..1)
  end
end
