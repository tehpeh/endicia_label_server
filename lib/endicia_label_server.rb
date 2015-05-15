module EndiciaLabelServer
  GEM_NAME = 'endicia_label_server'

  autoload :SERVICES,              "#{GEM_NAME}/services"

  autoload :Version,               "#{GEM_NAME}/version"
  autoload :Connection,            "#{GEM_NAME}/connection"
  autoload :Exceptions,            "#{GEM_NAME}/exceptions"
  autoload :Util,                  "#{GEM_NAME}/util"

  module Builders
    autoload :BuilderBase,         "#{GEM_NAME}/builders/builder_base"
    autoload :PostageRateBuilder,  "#{GEM_NAME}/builders/postage_rate_builder"
    autoload :PostageRatesBuilder, "#{GEM_NAME}/builders/postage_rates_builder"
    autoload :UserSignUpBuilder,   "#{GEM_NAME}/builders/user_sign_up_builder"
  end

  module Parsers
    autoload :ParserBase,          "#{GEM_NAME}/parsers/parser_base"
    autoload :PostageRateParser,   "#{GEM_NAME}/parsers/postage_rate_parser"
    autoload :PostageRatesParser,  "#{GEM_NAME}/parsers/postage_rates_parser"
    autoload :UserSignUpParser,    "#{GEM_NAME}/parsers/user_sign_up_parser"
  end
end
