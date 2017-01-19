class AsistenciasController < ApplicationController
  def new
  end

  def create
    # Esto tiene que ser la variable con múltiples asistencias del evento
    @asiste = Asistencia.new(asistencia_params)

    if @asiste.save
      flash[:success] = "Se registró exitosamente la asistencia"
      redirect_to eventosFeed_url
    else
      redirect_to eventoPlayers_path 
    end
  end

  private

    def asistencia_params
      params.require(:asistencia).permit(:evento_id, :player_id, :tipo, :comment)
    end
end
