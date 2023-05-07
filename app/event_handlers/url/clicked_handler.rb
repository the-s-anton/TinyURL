class Url::ClickedHandler < EventHandler
  # Event
  ######################################################################
  on Url::Clicked

  # Methods
  ######################################################################
  def perform
    url_id = event.id
    ip_address = event.ip_address

    Url::CountClick.new(url_id:, ip_address:).perform
  end
end