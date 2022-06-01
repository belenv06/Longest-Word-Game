require "open-uri"

class GamesController < ApplicationController

  def new
    vowels = ["a", "e", "i", "o", "u"]
    @letters = Array.new(5) { vowels.sample }
    @letters += Array.new(5) { (("a".."z").to_a - vowels).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = params[:word] || ""
    @included = include?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private
  def include?(your_word, my_letters)
    your_word.chars.all? do |letter|
      my_letters.include?(letter)
    end
  end

  def english_word?(your_word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{your_word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
