module Components
  module Home
    class Show < React::Component::Base
      define_state :internal
      define_state :internal2

      before_mount do
        internal! 0
        internal2! 0
      end

      def init_datepicker
        `$('#datepicker').datepicker();`
      end

      before_mount do
        # note that this will lazy load posts
        # and only the fields that are needed will be requested
        @posts = Post.all
      end

      def say(message)
        HTTP.post("/say/#{message}")
      end

      def subscribe(to)
        %x{
          App.cable.subscriptions.create(
            {
              channel: "SynchromeshChannel",
              synchromesh_channel: #{to}
            },
            {
              received: function(data) {
                #{yield Hash.new(`data`)}
                return true
              }
            }
          )
        }
      end


      after_mount do
        #init_datepicker
        # can't subscribe during prerendering :-)
        subscribe('Application') { |data| state.message! data[:message] }
      end

      def render
        div do
          p { "Internal state : #{internal}" }
          p { "Internal2 state : #{internal2}" }
          p { "Message from ActionCable : #{state.message}"}
          a { "increment internal state" }
            .on(:click) { state.internal! state.internal + 1 }
          OtherComponent().on(:increment) { internal2! internal2 + 1 }
          ['hi', 'bye', 'wazzup'].each do |message|
            button { "say #{message}" }.on(:click) { say(message) }
          end
          p do
            button { "bogus connection" }
            .on(:click) do
              subscribe('explode') # this tests or ability to avoid making an illegal connection
              alert('check out the server log for the error')
            end
          end
          ul do
            @posts.each do |p|
              li { p.title }
            end
          end
        end
      end
    end
  end
end
