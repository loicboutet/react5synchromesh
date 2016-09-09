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


      after_mount do
        init_datepicker
      end

      def render
        div do
          p { "Internal state : #{internal}" }
          p { "Internal2 state : #{internal2}" }
          a { "increment internal state" }
            .on(:click) { state.internal! state.internal + 1 }
          OtherComponent().on(:increment) { internal2! internal2 + 1 }
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
