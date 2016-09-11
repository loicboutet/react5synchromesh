module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # we always create a connection, and use the session_id to identify it.
    identified_by :session

    def connect
      self.session = cookies.encrypted[Rails.application.config.session_options[:key]]
    end
  end
end
