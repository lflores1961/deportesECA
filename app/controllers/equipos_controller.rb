class EquiposController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy]
  before_action :set_equipo,    only: [:show, :edit, :update, :destroy, :eventos_feed]
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
    @players = @equipo.players
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
      flash[:success] = "Se inserto exitosamente la nueva categoria."
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

  # GET /equipos/1/eventos_feed
  def eventos_feed
    @feed_eventos = @equipo.eventos
  end

  # GET /equipos/forma_rep
  def forma_rep
    @equipo = Equipo.new
    @entrenadores = User.all
  end

  # PUT /equipos/reporte_asist
  def reporte_asist

    if params[:entrenador]
      @entrenador = User.find(params[:entrenador].to_i)
      inicio = Time.parse(params[:inicio])
      final = Time.parse(params[:final])
      @equipos = @entrenador.equipos
      @eventos = reporte(@entrenador.id, inicio, final)
      puts '#' * 20
      puts @entrenador.name
      puts @eventos
      puts '#' * 20
    else
      @entrenador = current_user
      @equipos = @entrenador.equipos
      @equipos.each do |equi|
        @eventos << equi.eventos
      end
    end

    respond_to do |format|
      format.html
      format.xls
    end

  end

  private

  # Find correct set of eventos for user's teams
  def reporte entrena, inicio, final
    entrenador = User.find(entrena)
    equipos = entrenador.equipos

    @events = []
    equipos.each do |equipo|

      equipo.eventos.each do |event|
        puts '#' * 20
        puts inicio
        puts event.fecha
        puts final
        puts '#' * 20
        if (event.fecha >= inicio) && (event.fecha <= final)
          puts "Si pasa por aqui"
          @events << event
          p @events
        end
      end
    end
    return @events
  end

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
