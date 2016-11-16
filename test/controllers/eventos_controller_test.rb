require 'test_helper'

class EventosControllerTest < ActionDispatch::IntegrationTest

  def setup
    @evento = eventos(:entrene)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Evento.count' do
      post eventos_path, params: { evento: { fecha:@evento.fecha, tipo:@evento.tipo,
                                    equipo:@evento.equipo_id, comment:@evento.comment } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Evento.count' do
      delete evento_path(@evento)
    end
    assert_redirected_to login_url
  end
end
