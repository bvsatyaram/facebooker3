module Facebooker3
  module Routing
    module MapperExtensions
      def facebooker3
        @set.add_route("/facebookerauth", {:controller => "facebookerauth_controller", :action => "authorize"})
      end
    end
  end
end

ActionController::Routing::RouteSet.send :include, Facebooker3::Routing::MapperExtensions
