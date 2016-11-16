class PlayersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy]
before_action :set_player,    only: [:show, :edit, :update, :destroy]
before_action :set_secciones, only: [:new, :edit, :update, :create]
before_action :set_generos,   only: [:new, :edit, :update, :create]

  # GET /players
  # GET /players.json
  def index
    @players = Player.paginate(page: params[:page])
  end

  # GET /players/new
  def new
    @player = Player.new
    @equipos = Equipo.all
  end

  # GET /players/1/edit
  def edit
    @equipos = Equipo.all
  end

  # GET /players/1
  # GET /players/1.json
  def show

  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    if @player.save
      flash[:success] = 'Se inserto exitosamente el nuevo jugador.'
      redirect_to players_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update

    if @player.update(player_params)
      flash[:success] = 'Se actualizó exitosamente el jugador.'
      redirect_to players_path
    else
      render 'edit'
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    flash[:success] = 'Se eliminó correctamente el equipo.'
    redirect_to players_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  def set_secciones
    @secciones = ['Jardín de niños', 'Primaria', 'Secundaria', 'Bachillerato']
  end

  def set_generos
    @generos = ['Masculino', 'Femenino']
  end

  def player_params
    params.require(:player).permit(:apellidoPaterno, :apellidoMaterno, :nombres, :fechaNacimiento,
                                    :equipo_id, :seccion, :grupo, :genero, :beca)
  end
end
