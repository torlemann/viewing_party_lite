class User::MoviesController < ApplicationController

  before_action :get_user

  def discover
  end

  def index
    if params[:search] == "top rated"
      @movies = MoviesFacade.get_top_20_movies
    else
      @movies = MoviesFacade.get_search_results_movies(params[:search])
    end
  end

  def show
    @movie = MoviesFacade.get_movie(params[:id])
  end
  
end