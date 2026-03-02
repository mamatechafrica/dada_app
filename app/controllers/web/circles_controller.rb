class Web::CirclesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :topic ]
  before_action :authenticate_user!, only: [ :new_topic, :create_topic, :reply ]

  def index
    @circles = Circle.all
  end

  def show
    @circle = Circle.find_by_slug(params[:slug]) || Circle.find_by(id: params[:slug])
    @topics = @circle.topics.recent
  end

  def topic
    @topic = Topic.find(params[:topic_id])
    @circle = @topic.circle
    @posts = @topic.posts.order(created_at: :asc)

    # Increment view count
    @topic.increment!(:views_count)
  end

  def new_topic
    @circle = Circle.find_by_slug(params[:slug]) || Circle.find_by(id: params[:slug])
    @topic = Topic.new
  end

  def create_topic
    @circle = Circle.find_by_slug(params[:slug]) || Circle.find_by(id: params[:slug])
    @topic = @circle.topics.build(topic_params)
    @topic.user = current_user

    if @topic.save
      redirect_to circle_topic_path(@circle, @topic), notice: "Topic created!"
    else
      render :new_topic
    end
  end

  def reply
    @topic = Topic.find(params[:topic_id])
    @circle = @topic.circle

    content = params[:content]
    anonymous = params[:anonymous] == "1" || params[:anonymous] == true

    @post = @topic.posts.build(content: content, anonymous: anonymous)
    @post.user = current_user

    if @post.save
      redirect_to circle_topic_path(@circle, @topic), notice: "Reply posted!"
    else
      redirect_to circle_topic_path(@circle, @topic), alert: "Could not post reply."
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :content, :anonymous)
  end

  def post_params
    params.require(:post).permit(:content, :anonymous)
  end
end
