class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name ,presence: true,length: { minimum: 2,maximum: 25}
  validates :last_name ,presence: true,length: { minimum: 2,maximum: 25}
  mount_uploader :image, ImageUploader
  has_many:posts, dependent: :destroy
  has_many:comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :friend_sent , class_name: 'Friendship' ,
            foreign_key: 'sent_by_id',
            inverse_of: 'sent_by',dependent: :destroy
  has_many :friend_request ,class_name: 'Friendship',
            foreign_key: 'sent_to_id',
            inverse_of: 'sent_to',dependent: :destroy
  has_many :friends_a_to_b, -> {  Friendship.friends },
            through: :friend_sent,source: :sent_to
  has_many :friends_b_to_a, -> { Friendship.friends },
            through: :friend_request,source: :sent_by
  has_many :pending_requests, -> { Friendship.not_friends },
           through: :friend_sent, source: :sent_to
  has_many :received_requests, -> { Friendship.not_friends },
            through: :friend_request, source: :sent_by
  
  def all_friends
      (friends_a_to_b+friends_b_to_a).uniq
  end

  def self.search(searchstring,id1)
  	searchstring.strip!
    where("email like ?","%#{searchstring}%").or(where("first_name like ?","%#{searchstring}%").or(where("last_name like ?","%#{searchstring}%")))
  end

  def except_current_user(users)
  	users.reject { |user| user.id==self.id }
  end

  def full_name
  	"#{first_name} #{last_name}"
  end

end
