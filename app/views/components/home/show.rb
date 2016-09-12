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

      define_state :text
      define_state :message

      before_mount do
        # note that this will lazy load posts
        # and only the fields that are needed will be requested
        #@posts = Post.all
        state.text = ""
      end

      def say(message)
        HTTP.post("/say/#{message}")
      end

      def subscribe(to)
        %x{
          App2.cable.subscriptions.create(
            {
              channel: #{to}
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
        subscribe('OtherChannel') { |data| state.message! data[:message] }
      end

      def say(message)
        HTTP.post("/say/#{message}")
      end

      def render
        div do
          div do
            "message on another channel: #{state.message}"
          end
          div do
            ['hi', 'bye', 'wazzup'].each do |message|
              button { "say #{message}" }.on(:click) { say(message) }
            end
          end
          div do
            input(value: state.text).on(:change) do |e|
              state.text! e.target.value
            end
            button { "Post" }.on(:click) do |e|
              Post.new(title: state.text).save
              state.text! ""
            end
          end
          ul do
            Post.all.each do |p|
              li { button { "X" }.on(:click) { p.destroy }; p.title }
            end
          end
        end
      end
    end
  end
end
