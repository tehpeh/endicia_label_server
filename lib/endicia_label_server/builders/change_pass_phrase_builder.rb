require 'ox'

module EndiciaLabelServer
  module Builders
    class ChangePassPhraseBuilder < BuilderBase
      include Ox

      def initialize(opts = {}, root_attributes = nil)
        super('ChangePassPhraseRequest', opts, root_attributes)
        root[:TokenRequested] = 'false'
      end

      def post_field
        'ChangePassPhraseRequestXML'
      end
    end
  end
end
