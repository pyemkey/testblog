class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :comments
  has_many :posts
  has_many :votes
   
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  validates_presence_of :email
  validates_presence_of :encrypted_password

  has_many :posts

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  field :name, type: String
  field :nickname, type: String
  index({ email: 1 }, { unique: true, background: true })
  validates :name, presence: true
  validates :nickname, uniqueness: true, if: proc { |u| u.nickname }

  

  def owner? post
    posts.include? post
  end
  def add_comment comment 
    comments << comment
  end

  def to_s
    nickname.present? ? nickname : name
  end
end
