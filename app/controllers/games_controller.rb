class GamesController < ApplicationController
  require "json"
  require "open-uri"


  def new
    letters = ("A".."Z").to_a
    @randletters = letters.sample(10)
  end

  def score
    word_array = params[:input].downcase.chars
    letter_array = params[:letter].downcase.split(" ")

    url = "https://dictionary.lewagon.com/#{params[:input]}"
    dictionary_serialized = URI.open(url).read
    dictionary = JSON.parse(dictionary_serialized)

    word_array.each do |letter|
      if letter_array.include?(letter)
        letter_array.delete(letter)
      end
    end
        if letter_array.length == (10 - word_array.length) && dictionary["found"] ==true
          @answer = "valid guess!"
        elsif dictionary["found"] ==true
          @answer = "invalid attempt - #{word_array.join} can't be made out of #{params[:letter]} !"
        else
          @answer = "not valid"

        end


  end
end
