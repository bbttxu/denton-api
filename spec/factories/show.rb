FactoryGirl.define do
  factory :show do
    source "http://some.url.com/"
    starts_at Time.now + 1.day
    time_is_uncertain false

    venue
  end
end
