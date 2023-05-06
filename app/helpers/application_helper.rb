module ApplicationHelper
  include Pagy::Frontend

  def request_shortened_url(shortened_url)
    "#{request.base_url}/#{shortened_url}"
  end
end
