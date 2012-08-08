FactoryGirl.define do
  factory :booking do
    start_at Time.zone.parse('12:00')
    end_at Time.zone.parse('14:00')
    name 'Factory Name'
    date Date.parse('2012-2-29')
    majan_table
  end

  factory :day do
  end

  factory :majan_table do
  end
end
