#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8

require 'sinatra'
require 'view_grid'
require 'update_grid'
require 'file_gateway'

class GameStatePosition
  attr_reader :state
  attr_reader :result

  def save(state)
    @state = state
  end

  def save_result(result)
    @result = result
  end
end

get '/' do
  @game_state = GameStatePosition.new
  memory = FileGateway.new(@game_state)
  response = ViewGrid.new(game_state: memory).execute({})
  # puts params
  # response = ViewGrid.new(game_state: @game_state).execute({})
  grid = response[:grid]
  erb :index, locals: { grid: grid }
end

post '/make-move/0' do
  "Action Run"
  # puts params
  # UpdateGrid.new(:X, 0)
  # response = ViewGrid.new(game_state: @game_state).execute({})
  # grid = response[:grid]
  # erb :index, locals: { grid: grid }
end
