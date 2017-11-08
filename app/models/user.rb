class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include UserInfosConcern

  geocoded_by :city
  has_attachment :photo

  after_validation :geocode, if: :city_changed?

  enum gender: [ :male, :female ]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :bio, length: { maximum: 600 }


  def selected_users(birthday, male, female, length)
    # if (male + female)%2 == 0
    #   users = User.where(birthday: birthday).near(self.location, length*20000)
    # elsif male == 1
    #   users = User.where(birthday: birthday).male.near(self.location, length*20000)
    # elsif female == 1
    #   users = User.where(birthday: birthday).female.near(self.location, length*20000)
    # end
    # users
    User.all.select do |user|
      birthday.strftime("%m-%d") == user.birthday.strftime("%m-%d")
    end
  end

  def full_name
    a = first_name.capitalize
    b = last_name[0].upcase
    "#{a} #{b}."
  end

  def summary
    bio ? "#{bio[0..100]}#{"..." if bio.size > 100}" : "No content"
  end

  def location
    "#{city}, #{country[0..2]}"
  end

  def self.birthdate(params)
    year = params["birthdate(1i)"].to_i
    month = params["birthdate(2i)"].to_i
    day = params["birthdate(3i)"].to_i
    DateTime.new(year, month, day, 0, 0, 0, "+00:00")
  end

  def self.match_by_days
    # first_day = '2004-01-01'.to_datetime.to_i
    # last_day  = '2004-12-31'.to_datetime.to_i
    # days = (first_day .. last_day).step(1.day).map{ |day| Time.at(day).strftime("%m%d") }
    all.map{ |user| user.birthday.strftime("%m-%d") }
       .group_by{ |day| day }
       .map{ |k, v| {k => v.count} }
  end

  def self.matchs_number
    match_by_days.map{ |i| i.values }
       .flatten
       .select{|num| num > 1}
       .sum
  end

  def self.find_day_month(month, day)
    all.select do |user|
      user.birthday.strftime("%m%d").to_i == "#{month}#{day}".to_i
    end
  end

end
