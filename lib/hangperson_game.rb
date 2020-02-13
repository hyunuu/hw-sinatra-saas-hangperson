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
    @count = 0
    @word_with_guesses = ''
  end

  def guess(letter)
      if letter.nil?
	  raise ArgumentError, 'nil'
      end

      if letter.length == 0
	  raise ArgumentError, 'empty error'
      end

      unless letter =~ /[[:alpha:]]/
	  raise ArgumentError, 'must be an alphabet'
      end

      
      if letter.upcase == letter
	  return false
      end

      if @word.include? letter
	  unless @guesses.include? letter
	      @guesses << letter
	  else
	      return false
	  end
      else
	  unless @wrong_guesses.include? letter
	      @wrong_guesses << letter
	      @count += 1
	  else
	      return false
	  end
      end

      if @guesses.length == 0
	  return true
      end

  end


  def word_with_guesses
      printword = ""
      wordlength = @word.length
      for i in 0...wordlength
	  if @guesses.include? @word[i]
	      printword << @word[i]
	  else
	      printword << '-'
	  end
      end
      printword
  end


  def check_win_or_lose
      if @word.split(//).uniq.length == @guesses.length
	  :win
      else
	  if @count >= 7
	      :lose
	  else
	      :play
	  end
      end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
