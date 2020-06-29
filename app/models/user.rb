class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

   has_many  :books, dependent: :destroy

   validates :name, presence: true,length: {in: 2..20}
   validates :introduction,length: { maximum: 50}

   attachment :profile_image
 # deviseでemailを不必要にする
  def email_required?
   false
  end
  def email_changed?
   false
  end


end


