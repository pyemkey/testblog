class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates_presence_of :body, :title

  belongs_to :user

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end

  def hotness

    hot = case self.created_at.to_i
      when 1.days.ago.to_i..Time.now.to_i then 3
      when 3.days.ago.to_i..1.days.from_now.to_i then 2
      when 7.days.ago.to_i..3.days.from_now.to_i then 1
      else                           0
    end

    if hotness?
      hot+=1
    else
      hot
    end
  end
  
  private
    def hotness?
     self.comments.count >= 3
    end
end
