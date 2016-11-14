require 'test_helper'

class EventoTest < ActiveSupport::TestCase

  def setup
    @equipo = equipos(:osos)
    @evento = @equipo.eventos.build(fecha:'2016-11-09', tipo:'Entrenamiento', comment:'Local')
  end

  test "should be valid" do
    assert @evento.valid?
  end

  test "equipo_id should be present" do
    @evento.equipo_id = nil
    assert_not @evento.valid?
  end

  test "fecha must be present" do
    @evento.fecha = nil
    assert_not @evento.valid?
  end

  test "tipo must be present" do
    @evento.tipo = nil
    assert_not @evento.valid?
  end
end
