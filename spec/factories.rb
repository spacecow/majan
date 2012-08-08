FactoryGirl.define do
  factory :booking do
    start_at Time.zone.parse('12:00')
    end_at Time.zone.parse('14:00')
    name 'Factory Name'
    day
    majan_table
  end

  factory :day do
  end

  factory :majan_table do
  end
end
