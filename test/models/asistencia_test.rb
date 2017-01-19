require 'test_helper'

class AsistenciaTest < ActiveSupport::TestCase

  def setup
    @evento = eventos(:entrene)
    @player = players(:armenta)
    @asisten = Asistencia.new(evento_id:@evento.id, player_id:@player.id, tipo:'asistencia', comment:'No hay comment')
  end

  test "should be valid" do
    assert @asisten.valid?
  end
end
