class Booking < ActiveRecord::Base
  belongs_to :majan_table

  attr_accessible :start_at, :end_at, :date, :majan_table_id, :name

  validates_presence_of :start_at, :end_at, :date, :name
  validate :start_at_time_span
  validate :end_at_time_span
  validate :start_before_end

  BASE_TIME_START = Time.parse('8:00')
  BASE_TIME_END   = Time.parse('18:00')

  def book
    bookings = Booking.find_all_by_date(date) || []
    tables = MajanTable.all
    bookings.each do |booking|
      if booking.collision?(start_at, end_at)
        tables.delete(booking.majan_table)
      end
    end
    if tables.present?
      self.majan_table = tables.first
      true 
    else
      false
    end
  end

  def collision?(start_at, end_at)
    return false if Booking.before(start_at, self.start_at) and Booking.before(end_at, self.start_at)
    return false if Booking.after(start_at, self.end_at) and Booking.after(end_at, self.end_at)
    return true
  end

  def info
    "#{start_at.strftime('%k:%M')}~#{end_at.strftime('%k:%M')} #{name}"
  end

  class << self
    def after(t1, t2)
      (t1.hour*60 + t1.min) >= (t2.hour*60 + t2.min)
    end

    def before(t1, t2)
      (t1.hour*60 + t1.min) <= (t2.hour*60 + t2.min)
    end

    def correct_time!(params)
      correct_start_at!(params)
      correct_end_at!(params)
    end
    def correct_start_at!(params)
      t = params[:booking][:start_at]
      if data = t.match(/^\d{1}$|^\d{2}$/)
        params[:booking][:start_at] = data[0]+':00'
      elsif data = t.match(/^\d{3}$|^\d{4}$/)
        params[:booking][:start_at] = data[0][0..-3]+':'+data[0][-2..-1]
      end
    end    
    def correct_end_at!(params)
      t = params[:booking][:end_at]
      if data = t.match(/^\d{1}$|^\d{2}$/)
        params[:booking][:end_at] = data[0]+':00'
      elsif data = t.match(/^\d{3}$|^\d{4}$/)
        params[:booking][:end_at] = data[0][0..-3]+':'+data[0][-2..-1]
      end
    end    

    def minutes(time) time.hour*60+time.min end
  end

  private

    def start_at_time_span
      return if start_at.nil?
      if Booking.minutes(self.start_at) - Booking.minutes(BASE_TIME_START) < 0
        errors.add(:start_at, I18n.t("errors.messages.greater_than_or_equal_to",count:BASE_TIME_START.strftime("%k:%M")))
      elsif Booking.minutes(BASE_TIME_END) - Booking.minutes(self.start_at) < 0
        errors.add(:start_at, I18n.t("errors.messages.less_than_or_equal_to",count:BASE_TIME_END.strftime("%k:%M")))
      end
    end

    def end_at_time_span
      return if end_at.nil?
      if Booking.minutes(self.end_at) - Booking.minutes(BASE_TIME_START) < 0
        errors.add(:end_at, I18n.t("errors.messages.greater_than_or_equal_to",count:BASE_TIME_START.strftime("%k:%M")))
      elsif Booking.minutes(BASE_TIME_END) - Booking.minutes(self.end_at) < 0
        errors.add(:end_at, I18n.t("errors.messages.less_than_or_equal_to",count:BASE_TIME_END.strftime("%k:%M")))
      end
    end

    def start_before_end
      return if start_at.nil?
      return if end_at.nil?
      if Booking.minutes(self.end_at) - Booking.minutes(self.start_at) < 0
        errors.add(:start_at, I18n.t("errors.messages.start_before_end"))
      end
    end
end
