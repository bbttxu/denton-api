FactoryGirl.define do
  sequence :name do |n|
    "Venue #{n}"
  end

  sequence :slug do |n|
    "slug#{n}"
  end

  sequence :phone do |y|
    "555#{y}940214"
  end

  sequence :address do |n|
    "#{n} main st"
  end

  factory :venue do
    name
    slug
    sequence :phone do |n| "phone #{n}" end
    address
  end
end
