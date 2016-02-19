class HomepageController < ApplicationController
  def index
    @users = User.all.order_by(:elo => 'desc')
  end
end
