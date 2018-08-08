#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8

require 'sinatra'
require 'view_grid'
require 'update_grid'
require 'disk_based_memory'
require 'human_plays'
require 'ai_player'
require 'minimax'

before do
  @memory = DiskBasedMemory.new
  @view_grid = ViewGrid.new(game_state: @memory)
end

get '/' do
  response = @view_grid.execute({})
  grid = @memory.state
  if @memory.result == :winner
    result = 'Computer wins'
    @memory.delete_all
  elsif @memory.result == :draw
    result = 'Draw'
    @memory.delete_all
  end
  erb :index, locals: { 
    grid: grid, 
    result: result,
    invalid_move: params['error'] == 'invalid'
  }
end

post '/make-move/:id' do
  update_grid = UpdateGrid.new(game_state: @memory)
  if end_of_game?(@memory) || !@memory.state[params[:id].to_i].nil?
    redirect '/?error=invalid'
  else
    HumanPlayer.new(update_grid: update_grid, game_state: @memory).plays(params[:id].to_i)
    AIPlayer.new(update_grid: update_grid, game_state: @memory).execute unless @memory.result == :draw
  end
  redirect '/'
end


post '/reset' do
  @memory = DiskBasedMemory.new
  @memory.delete_all

  redirect '/'
end

def end_of_game?(memory)
  @memory.result == :winner || @memory.result == :draw
end
