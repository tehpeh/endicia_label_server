module EndiciaLabelServer
  module Parsers
    class UserSignUpParser < ParserBase
      attr_accessor :confirmation_number, :account_id

      def value(value)
        super
        self.confirmation_number = value.as_s if switch_active? :ConfirmationNumber
        self.account_id = value.as_s if switch_active? :AccountID
      end

      def success?
        !['0', 0].include? confirmation_number
      end
    end
  end
end
