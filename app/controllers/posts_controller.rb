class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user: current_user))

    if @post.save!
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @posts = Post.all
    @users = User.all
  end

  private
  def post_params
    params.expect(post: [ :title, :body ])
  end
end
