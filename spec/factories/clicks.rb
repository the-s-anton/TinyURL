FactoryBot.define do
  factory :click do
    url { create(:url) }
  end
end
