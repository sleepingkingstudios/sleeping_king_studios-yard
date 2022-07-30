# frozen_string_literal: true

require 'sleeping_king_studios/yard'

module SleepingKingStudios::Yard
  # Namespace for commands, which parse and generate documentation files.
  module Commands
    autoload :Generators, 'sleeping_king_studios/yard/commands/generators'
    autoload :Parse,      'sleeping_king_studios/yard/commands/parse'
  end
end