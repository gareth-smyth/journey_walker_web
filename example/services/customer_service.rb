module JourneyWalkerWeb
  module Example1
    # Simple example class acts like a real service (would take some sort of customer_id, security token etc. in real
    # life too)
    class CustomerService
      @email_address = 'someone@example.com'

      def self.fetch_class_email
        @email_address
      end

      def fetch_email
        self.class.fetch_class_email
      end
    end
  end
end
