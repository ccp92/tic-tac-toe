#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8

require 'sinatra'
require 'view_grid'
require 'update_grid'
require 'disk_based_memory'
require 'human_plays'
require 'ai_plays'
require 'minimax'

get '/' do
  memory = DiskBasedMemory.new
  response = ViewGrid.new(game_state: memory).execute({})
  # puts params
  # response = ViewGrid.new(game_state: @game_state).execute({})
  grid = memory.state
  erb :index, locals: { grid: grid }
end

post '/make-move/:id' do
  memory = DiskBasedMemory.new
  update_grid = UpdateGrid.new(game_state: memory)
  HumanPlayer.new(update_grid: update_grid, game_state: memory).plays(params[:id].to_i)
  AIPlayer.new(update_grid: update_grid, game_state: memory).execute
  redirect '/'
end


post '/reset' do
  memory = DiskBasedMemory.new
  memory.delete_all

  redirect '/'
end

