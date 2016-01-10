module JourneyWalkerWeb
  module Example1
    # Simple example class acts like a real service taking a user id and allowing access to customer info
    class CustomerService
      @email_address_one = 'someone@example.com'
      @email_address_two = 'someone_else@example.com'

      def self.fetch_class_email(user)
        return @email_address_one if user == 'one'
        @email_address_two
      end

      def fetch_email(user)
        self.class.fetch_class_email(user)
      end
    end
  end
end
