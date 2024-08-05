require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    result = URI.open("https://dictionary.lewagon.com/#{params[:word]}").read
    result = JSON.parse(result)
    word = params[:word].upcase # what they typed in the form
    letters = params[:letters].split('')
    @score = session[:score] || 0
    if word.split('').any? { |char| word.count(char) > letters.count(char) }
      @result = "Sorry but #{word} can't be built out of #{letters.join(', ')}"
    elsif result['found'] == true
      @result = "Congratulations! #{word} is a valid English word!"
      @score += word.length
      session[:score] = @score
    else
      @result = "Sorry but #{word} does not seem to be a valid English word..."
    end
  end
end
