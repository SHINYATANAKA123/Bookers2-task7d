class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followeds, through: :active_relationships, source: :follower
  has_many :followers, through: :passive_relationships, source: :followed
  

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  def followed_by?(user)
    passive_relationships.where(followed_id: user.id).exists?
  end
  
end
