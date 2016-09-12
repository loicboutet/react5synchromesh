class HomeController < ApplicationController
  def show
    render_component
  end

  def say
    ActionCable.server.broadcast("OtherChannel", message: params[:message])
    render nothing: true
  end

end
