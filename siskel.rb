require 'httparty'

class Siskel
  attr_reader :title, :rating, :year, :plot
  def initialize(title, options = {})
    year = options[:year]
    plot_type = options[:plot]
    @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&y=#{options[:year]}&plot=#{plot_type}&tomatoes=true")
    @tomato = @movie["tomatoMeter"].to_f
    @title = @movie['Title']
    @rating = @movie["Rated"]
    @year = @movie["Year"]

    @plot = @movie["Plot"]
  end

  def consensus
    if @tomato >= 50
      "Thumbs Down"
    else
      "Thumbs Up"
    end
  end

  def title
    if @title == nil
      @title = "Movie not found!"
    else
      @title = @movie['Title']
    end
  end
end
