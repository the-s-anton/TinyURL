class Url::CountClick < Operation
  class Params < Operation::Params
    attribute :url_id, Types::Coercible::String
    attribute :ip_address, Types::Coercible::String
    attribute :user_agent, Types::Coercible::String
  end

  class Response < Operation::Response
    attribute :url_id, Types::Coercible::String
  end

  def perform
    url.clicks.create!(ip_address: params.ip_address, user_agent: params.user_agent)

    { url_id: url.id }
  end

  private

  def url
    @url ||= Url.find(params.url_id)
  end
end
