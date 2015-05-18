require 'ox'

module EndiciaLabelServer
  module Builders
    # The {PostageRateBuilder} class builds Endicia XML PostageRate Objects.
    #
    # @author Paul Trippett
    # @since 0.1.0
    class PostageRateBuilder < BuilderBase
      include Ox

      # Initializes a new {RateBuilder} object
      #
      def initialize(opts = {})
        super 'PostageRateRequest', opts
      end

      def post_field
        'postageRateRequestXML'
      end
    end
  end
end
