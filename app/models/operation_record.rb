class OperationRecord < ApplicationRecord
  # Table name
  ######################################################################
  #
  # Operation.rb is a lib file, not a model file
  self.table_name = 'operations'

  # Dry::Struct
  ######################################################################
  attribute :name, :string
  attribute :status, :string
  attribute :params, :jsonb
  attribute :response, :jsonb
end
