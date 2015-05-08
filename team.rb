class Team

	attr_reader :name, :wins, :draws, :loses

	def initialize(name)
		@name = name.capitalize
		@wins = 0
		@draws = 0
		@loses = 0
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

end