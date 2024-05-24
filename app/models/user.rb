class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :valid_phone_number

  enum role: { client: 0, admin: 1 }

  has_many :addresses

  def valid_phone_number
    unless Phonelib.valid_for_country?(phone_number, 'PH')
      errors.add(:phone_number, "Phone number should be valid.")
    end
  end
end