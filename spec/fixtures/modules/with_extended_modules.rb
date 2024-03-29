# frozen_string_literal: true

require 'forwardable'

module Atmosphere
  def dew_point; end
end

module Revenge; end

module Phenomena
  module WeatherEffects
    include Atmosphere

    attr_accessor :pressure

    def temperature
      'cold'
    end
  end
end

# This module is out of this world.
module Space
  extend Forwardable
  extend Revenge
  extend Phenomena::WeatherEffects
end
