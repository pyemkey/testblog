class PostsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:posts) { Post.all }
  expose_decorated(:post, attributes: :post_params)
  expose(:tag_cloud) { [] }

  def index
    tag_cloud.concat(posts.tags_with_weight)    
  end

  def new
  end

  def edit
  end

  def update
    if post.save
      render action: :index
    else
      render :new
    end
  end

  def destroy
    post.destroy if isOwner?
    render action: :index
  end

  def show
    if isOwner?
      @comments = post.comments
    else
      @comments = post.comments.where(abusive: false)        
    end
    
    @comment = current_user.comments.new
    @comment.post_id = post.id
  end

  def mark_archived
    #post = Post.find params[:id]
    post.archive!
    render action: :index
  end

  def create
    post.user = current_user
    if post.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def comments
    comment = isOwner? ? post.comments : post.comments.where(abusive: false)
  end

  private
    def isOwner?
      current_user.owner? post
    end

    def sorting_tag_clouds!
      tag_cloud.group_by { |i| i}.map { |k,v| [k, v.count.to_f] }.sort!
    end

    def post_params
      return if %w{mark_archived}.include? action_name
      params.require(:post).permit(:body, :title, :tags)
    end
end
