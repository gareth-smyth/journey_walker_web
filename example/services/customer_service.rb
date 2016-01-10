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

      def self.update_class_email(user, email_address)
        @email_address_one = email_address if user == 'one'
        @email_address_two = email_address if user != 'one'
      end

      def update_email(user, email_address)
        self.class.update_class_email(user, email_address)
      end
    end
  end
end
