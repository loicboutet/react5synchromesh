module Components
  module Home
    class OtherComponent < React::Component::Base
      param :on_increment, type: Proc, allow_nil: true, default: nil

      def render
        div do
          a{"increment external state"}.on(:click) { params.on_increment }
        end
      end
    end
  end
end
