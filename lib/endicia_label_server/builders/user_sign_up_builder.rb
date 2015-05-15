require 'ox'

module EndiciaLabelServer
  module Builders
    # The {UserSignUpBuilder} class builds Endicia XML Rate Objects.
    #
    # @author Paul Trippett
    # @since 0.1.0
    class UserSignUpBuilder < BuilderBase
      include Ox

      # Initializes a new {RateBuilder} object
      #
      def initialize
        super 'UserSignUpRequest'
      end

      def post_field
        'UserSignUpRequestXML'
      end
    end
  end
end
