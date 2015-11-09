class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

 attr_accessor :word
 attr_accessor :guesses
 attr_accessor :wrong_guesses
 attr_accessor :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = '' 
    @wrong_guesses = ''
    @word_with_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError unless letter =~ /[a-z]/i
    unless @guesses.downcase.include?(letter.downcase) or @wrong_guesses.downcase.include?(letter.downcase) then
      @word.include?(letter) ? (@guesses << letter) : (@wrong_guesses << letter)  
      @word_with_guesses = @word.chars.map {|item| @guesses.include?("#{item}") ? (item) : ("-")}.join
    else
      return false
    end
    true
  end

  def check_win_or_lose()
    if @guesses.chars.count <= @word.chars.count and (@guesses.chars.count + @wrong_guesses.chars.count < 7) then
      @word_with_guesses.include?("-") ? (return :play) : (return :win)
    else  
      return :lose
    end
  end
end
