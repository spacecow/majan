FactoryGirl.define do
  factory :booking do
    start_at Time.zone.parse('12:00')
    end_at Time.zone.parse('14:00')
  end

  factory :day do
  end

  factory :table do
  end
end
