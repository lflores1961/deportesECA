class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
      format.xls
    end
  end

  # POST /users/import
  def import
    User.import(params[:file])
    flash[:success] = 'Se ha importado exitosamente el archivo de usuarios a la base de datos.'
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Uncomment next block to replace email activation if you are not
      # performing email activation.
      #log_in @user
      #flash[:success] = "Bienvenido a la aplicación de Deportes ECA"
      #redirect_to @user
      # End of -no activation block-
      # Uncomment next line to perform email activation
      #@user.send_activation_email
      # Comment next line if you are performing email activation
      @user.activate
      flash[:info] = "Se creo correctamente la cuenta del usuario"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Perfil actualizado."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario eliminado"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :admin)
    end

    # before filters.

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      #redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
