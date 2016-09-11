class SynchromeshChannel < ApplicationCable::Channel

  def subscribed
    # the synchromesh_channel param is sent up from the client
    stream_from "synchromesh-#{params[:synchromesh_channel]}"
  end

  def initialize(*args)
    # so here is where we would interact with synchromesh to insure that the
    # current user (as identified via session_id) can use this channel, if NOT
    # we raise an error which will kill this connection
    # for a test we will kill the connection if args[2] (the params) is wrong:
    raise "illegal channel connection attempt" if args[2]["synchromesh_channel"] == "explode"
    super
  end
end
