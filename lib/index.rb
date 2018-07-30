#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8

require 'sinatra'
require 'view_grid'

get '/' do
  @grid = ViewGrid.new(game_state: nil)
  erb :index, locals: { grid: @grid }
end
