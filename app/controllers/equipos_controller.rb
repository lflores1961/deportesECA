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

    respond_to do |format|
      if @equipo.save
        format.html { redirect_to equipos_path, notice: 'Se inserto exitosamente la nueva categoría.' }
        format.json { render :show, status: :created, location: @equipo }
      else
        format.html { render :new }
        format.json { render json: @equipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipos/1
  # PATCH/PUT /equipos/1.json
  def update
    respond_to do |format|
      if @equipo.update(equipo_params)
        format.html { redirect_to equipos_path, notice: 'Se actualizó exitosamente el equipo.' }
        format.json { render :show, status: :ok, location: @equipo }
      else
        format.html { render :edit }
        format.json { render json: @equipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipos/1
  # DELETE /equipos/1.json
  def destroy
    @equipo.destroy
    respond_to do |format|
      format.html { redirect_to equipos_url, notice: 'Se eliminó correctamente el equipo.' }
      format.json { head :no_content }
    end
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
