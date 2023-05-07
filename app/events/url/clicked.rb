class Url::Clicked < Event
  # Dry::Struct
  ######################################################################
  attribute :id, Types::Coercible::String
  attribute :ip_address, Types::Coercible::String
end
