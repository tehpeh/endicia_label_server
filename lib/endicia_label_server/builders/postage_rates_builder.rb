require 'ox'

module EndiciaLabelServer
  module Builders
    # The {PostageRatesBuilder} class builds Endicia XML Rate Objects.
    #
    # @author Paul Trippett
    # @since 0.1.0
    class PostageRatesBuilder < BuilderBase
      include Ox

      # Initializes a new {RateBuilder} object
      #
      def initialize
        super 'PostageRatesRequest'
      end

      def post_field
        'postageRatesRequestXML'
      end
    end
  end
end
