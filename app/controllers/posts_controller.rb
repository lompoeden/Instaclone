before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: "DESC")
    @users = User.all.order(created_at: "DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      @post.save
      PostMailer.contact_mail(@post).deliver
      flash[:notice] = '記事を投稿しました'
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = '記事を編集しました'
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = '記事を削除しました'
    redirect_to posts_path
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :image_cache)
  end
end
