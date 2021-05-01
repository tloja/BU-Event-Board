class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  validates :name, :email, :presence => true
  has_one :profile, :dependent => :destroy  
  def self.create_with_omniauth info
      create!(name: info['name'], email: info['email'])
  end
  validate :staff_or_student
  
  def staff_or_student
    errors.add(:email, "must be for Binghamton University") if
      email.split('@')[1] != "binghamton.edu"
  end  
end
  # Note that self is the **user**
  def create_profile
        Profile.create(user_id: self.id)
  end

class Authorization < ActiveRecord::Base
  belongs_to :user  # should be there already
  validates :provider, :uid, :presence => true
  
end

  #create new user
  
