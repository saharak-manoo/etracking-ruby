module Etrackings
  VERSION_INFO = [3, 0, 0].freeze
  VERSION = VERSION_INFO.map(&:to_s).join('.').freeze

  def self.version
    VERSION
  end
end
