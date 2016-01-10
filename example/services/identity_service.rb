module JourneyWalkerWeb
  module Example1
    # Simple example class acts like a real service (would take some sort of customer_id, security token etc. in real
    # life too)
    class IdentityService
      def identity
        'two'
      end
    end
  end
end
