module EndiciaLabelServer
  module Parsers
    class UserSignUpParser < ParserBase
      attr_accessor :confirmation_number, :account_id

      def value(value)
        super

        string_value = value.as_s
        if switch_active? :ConfirmationNumber
          self.confirmation_number = string_value
        elsif switch_active? :AccountID
          self.account_id = string_value
        end
      end

      def success?
        !['0', 0].include? confirmation_number
      end
    end
  end
end
