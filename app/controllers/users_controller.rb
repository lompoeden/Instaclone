before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
 before_action :forbid_login_user, {only: [:new, :create]}
 before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

 def index
   @users = User.all.order(created_at: "DESC")
 end

 def new
   @user = User.new
 end

 def create
   @user = User.new(user_params)
   if @user.save
     flash.now[:notice] = 'ユーザ登録しました'
     session[:user_id] = @user.id
     redirect_to posts_path
   else
     render 'new'
   end
 end

 def show
   @user = User.find(params[:id])
 end

 def edit
   @user = User.find(params[:id])
 end

 def update
   @user = User.find(params[:id])
   if @user.update(user_params)
     flash[:notice] = 'ユーザ情報を編集しました'
     redirect_to user_path(@user.id)
   else
     render 'edit'
   end
 end

 def destroy
   @user = User.find(params[:id])
   @user.destroy
   flash.now[:notice] = 'ユーザを削除しました'
   redirect_to new_user_path
 end

 def ensure_correct_user
   if current_user.id != params[:id].to_i
     flash[:notice] = '権限がありません'
     redirect_to posts_path
   end
 end

 private

 def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :icon_cache)
 end
