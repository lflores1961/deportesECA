class EquiposController < ApplicationController
  before_action :set_equipo,    only: [:show, :edit, :update, :destroy]
  before_action :set_deportes,  only: [:new, :edit, :create]
  before_action :set_categorias, only: [:new, :show, :edit, :update, :create]
  before_action :set_ramas,      only: [:new, :show, :edit, :update, :create]

  # GET /equipos
  # GET /equipos.json
  def index
    @equipos = Equipo.paginate(page: params[:page])
  end

  # GET /equipos/1
  # GET /equipos/1.json
  def show
    @entrenador = User.find(@equipo.user_id)
    @categoria = Categoria.find(@equipo.categoria)
  end

  # GET /equipos/new
  def new
    @equipo = Equipo.new
    @usuarios = User.all
  end

  # GET /equipos/1/edit
  def edit
    @usuarios = User.all
  end

  # POST /equipos
  # POST /equipos.json
  def create
    @equipo = Equipo.new(equipo_params)

    if @equipo.save
      flash[:success] = 'Se inserto exitosamente la nueva categoría.'
      redirect_to equipos_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /equipos/1
  # PATCH/PUT /equipos/1.json
  def update

    if @equipo.update(equipo_params)
      flash[:success] = 'Se actualizó exitosamente el equipo.'
      redirect_to equipos_path
    else
      render 'edit'
    end
  end

  # DELETE /equipos/1
  # DELETE /equipos/1.json
  def destroy
    @equipo.destroy
    flash[:success] = 'Se eliminó correctamente el equipo.'
    redirect_to equipos_url
  end

  private

  # Set @deportes to select from in form.
  def set_deportes
    @deportes = ['football soccer', 'Volley ball', 'Basket ball', 'Soft ball', 'Tennis' ]
  end

  def set_ramas
    @ramas = ['Varonil', 'Femenil', 'Mixto']
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_equipo
    @equipo = Equipo.find(params[:id])
  end

  def set_categorias
    @categorias = Categoria.all
  end

  def equipo_params
    params.require(:equipo).permit(:name, :categoria, :deporte, :rama, :user_id)
  end
end
