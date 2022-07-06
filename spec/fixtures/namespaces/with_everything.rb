# frozen_string_literal: true

ELDRITCH = 'Unearthly, supernatural, eerie.'

SQUAMOUS = 'Covered, made of, or resembling scales.'

class Assembly; end

class Part; end

class Rocket; end

module Alchemy; end

module Clockwork; end

module Sorcery; end

class << self
  attr_reader :gravity

  attr_writer :secret_key

  attr_accessor :sandbox_mode

  def calculate_isp(engine); end

  def plot_trajectory; end
end

attr_reader :base_mana

attr_writer :secret_formula

attr_accessor :magic_enabled

def convert_mana; end

def summon_dark_lord(name:); end
