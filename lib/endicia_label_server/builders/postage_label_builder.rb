require 'ox'

module EndiciaLabelServer
  module Builders
    # The {PostageLabelBuilder} class builds Endicia XML LabelRequest
    # Objects.
    #
    # @author Paul Trippett
    # @since 0.1.0
    class PostageLabelBuilder < BuilderBase
      include Ox

      # Initializes a new {RateBuilder} object
      #
      def initialize(opts = {}, root_attributes = nil)
        super('LabelRequest', opts, root_attributes)
      end

      def post_field
        'labelRequestXML'
      end
    end
  end
end
