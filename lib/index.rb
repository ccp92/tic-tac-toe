#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8

require 'sinatra'
require 'view_grid'
require 'update_grid'
require 'disk_based_memory'


get '/' do
  memory = DiskBasedMemory.new
  response = ViewGrid.new(game_state: memory).execute({})
  # puts params
  # response = ViewGrid.new(game_state: @game_state).execute({})
  grid = memory.state
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
