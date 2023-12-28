# app/controllers/pokemon_controller.rb
class PokemonController < ApplicationController
skip_before_action :verify_authenticity_token, only: [:clear_pokemon]
  require 'httparty'

  def index

  end

  def page_two
    @myvar="cool"
  end
  def fetch_pokemon
    response = HTTParty.get('https://pokeapi.co/api/v2/pokemon?limit=3')
    @pokemon_data = JSON.parse(response.body)
    flash[:success] = 'Pokemon successfully loaded!'
    respond_to do |format|
      format.html { render partial: 'pokemon_names' }
    end
  end

  


  def clear_pokemon
    @pokemon_data = { 'results' => [] }

    respond_to do |format|
      format.html { render partial: 'text_partial' }
    end
  end
  

  def fetch_pokemont
    response = HTTParty.get('https://pokeapi.co/api/v2/pokemon?limit=3')
    @pokemon_data = JSON.parse(response.body)
    flash[:success] = 'Pokemon successfully loadedzz!'
    turbo_stream.append 'pokemon-list' do
      render partial: 'pokemon_turbo_names', locals: { pokemon_data: @pokemon_data }
    end
  end


  # def fetch_pokemon_names
  #   @pokemons = Pokemon.pluck(:name)
  #   render partial: 'pokemon_names'
  # end

end



