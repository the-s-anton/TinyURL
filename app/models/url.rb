class Url < ApplicationRecord
  # Associations
  ######################################################################
  #
  # Regular URI.regexp can't handle all valid URLs, so we use a custom one
  REGEXP_URL_FORM = %r{^(http|https)://[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(/.*)?$}ix

  # Callbacks
  ######################################################################
  before_validation :generate_shortened!, on: :create, unless: :shortened?
  before_validation :format_original!, on: :create

  # Validations
  ######################################################################
  validates :original, presence: true, format: { with: REGEXP_URL_FORM, multiline: true }
  validates :shortened, presence: true, uniqueness: true
  validates :clicks_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :clicks_count_unique, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Private methods
  ######################################################################
  #
  # Generate a unique shortened string
  def generate_shortened!
    self.shortened = loop do
      code = SecureRandom.hex(3)
      break code unless self.class.exists?(shortened: code)
    end
  end

  # Add http:// to original if it's missing
  def format_original!
    return if original[%r{\Ahttp://}] || original[%r{\Ahttps://}]

    self.original = "http://#{original}"
  end
end
