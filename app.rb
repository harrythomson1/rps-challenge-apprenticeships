require 'sinatra/base'
require_relative './lib/computer_choice'
require_relative './lib/game'
require_relative './lib/player'

class RockPaperScissors < Sinatra::Base

  enable :sessions

  get '/' do
    erb :index
  end

  post '/name' do
    session[:player] = Player.new(params[:name])
    redirect '/play'
  end

  post '/multiplayer' do
    session[:player_1] = Player.new(params[:player_1_name])
    session[:player_2] = Player.new(params[:player_2_name])
    redirect '/player-1-choice'
  end

  get '/player-1-choice' do
    @player_1 = session[:player_1]
    p params[:choice]
    @player_1_choice = params[:choice]
    erb :player_1_choice
  end

  get '/player-2-choice' do
    @player_2 = session[:player_2]
    session[:player_1_choice] = params[:choice]
    erb :player_2_choice
  end

  get '/multiplayer-play' do
    @player_1 = session[:player_1]
    @player_2 = session[:player_2]
    @result = Game.new(session[:player_1_choice], params[:choice]).play
    erb :result
  end

  get '/play' do
    @player = session[:player]
    erb :play
  end

  get '/rock' do
    @player = session[:player]
    @computer_choice = ComputerChoice.new.make_decision
    @result = Game.new('rock', @computer_choice).play
    erb :result
  end

  get '/paper' do
    @player = session[:player]
    @computer_choice = ComputerChoice.new.make_decision
    @result = Game.new('paper', @computer_choice).play
    erb :result
  end

  get '/scissors' do
    @player = session[:player]
    @computer_choice = ComputerChoice.new.make_decision
    @result = Game.new('scissors', @computer_choice).play
    erb :result
  end

  run! if app_file == $0
end
