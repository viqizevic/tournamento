require_relative 'match'

class Team

	attr_reader :name, :wins, :draws, :loses, :matches

	def initialize(name)
		@name = name.strip
		@wins = 0
		@draws = 0
		@loses = 0
		@matches = []
	end

	def win_one_game
		@wins += 1
	end

	def play_draw
		@draws += 1
	end

	def lose_one_game
		@loses += 1
	end

	def to_s
		"#{@name} (W#{@wins} D#{@draws} L#{@loses})"
	end

	def add_match(match)
		@matches << match
		# TODO: should check if the match really belongs to this team
	end

end