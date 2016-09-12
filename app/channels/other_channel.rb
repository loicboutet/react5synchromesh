class OtherChannel < ApplicationCable::Channel

  def subscribed
    stream_from "OtherChannel"
  end
end
