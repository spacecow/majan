FactoryGirl.define do
  factory :booking do
    start_at Time.parse('12:00')
    end_at Time.parse('14:00')
  end

  factory :day do
  end
end
