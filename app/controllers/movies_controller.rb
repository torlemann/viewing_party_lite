class MoviesController < ApplicationController

  def discover
  end

  def index
    if params[:search] == "top rated"
      @page = params[:page] || "1"
      @movies = MoviesFacade.get_top_movies(@page.to_i)
    else
      @movies = MoviesFacade.get_search_results_movies(params[:search])
    end
  end

  def show
    @movie = MoviesFacade.get_movie(params[:id])
  end
  
end