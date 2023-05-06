class Click < ApplicationRecord
  # Associations
  ######################################################################
  belongs_to :url, class_name: Url.name

  # Callback
  ######################################################################
  counter_culture :url
  counter_culture :url, column_name: proc { |model|
    model.class.where(ip_address: model.ip_address, url: model.url).count > 1 ? nil : 'clicks_count_unique'
  }

  # Validations
  ######################################################################
  validates :ip_address, presence: true
end
