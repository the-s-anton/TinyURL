class EventRecord < ApplicationRecord
  # Table name
  ######################################################################
  #
  # Event.rb is a lib file, not a model file
  self.table_name = 'events'

  # Dry::Struct
  ######################################################################
  attribute :name, :string
  attribute :params, :jsonb
end
