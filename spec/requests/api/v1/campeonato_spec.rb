require 'rails_helper'

RSpec.describe 'api/v1/campeonato', type: :controller do
  describe Api::V1::CampeonatosController do
    before :each do
      usuario = create(:usuario)
      campeonato = create(:campeonato)
      campeonato = create(:campeonato_inativo, nome: 'Campeonato 2')
      usuario.campeonatos << Campeonato.all
      usuario.save!

      sign_in usuario
    end

    it "Retorna todos os campeonatos" do
      get :index

      expect(response).to have_http_status(200)
      expect(response.body).to eq(Campeonato.all.to_json)
    end

    it "Retorna apenas campeonatos ativos" do
      get :index, params: { somente_ativos: true }
      expect(response.body).to eq(Campeonato.ativos.to_json)
    end
  end
end
