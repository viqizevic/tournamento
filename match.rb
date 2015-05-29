class Match

	attr_reader :home_team, :away_team, :home_goals, :away_goals

	def initialize(home_team, away_team, home_goals, away_goals)
		@home_team = home_team
		@away_team = away_team
		@home_goals = home_goals
		@away_goals = away_goals
		if home_goals > away_goals
			home_team.win_one_game
			away_team.lose_one_game
		elsif home_goals == away_goals
			home_team.play_draw
			away_team.play_draw
		else
			away_team.win_one_game
			home_team.lose_one_game
		end
		home_team.add_match(self)
		away_team.add_match(self)
	end

	def to_s
		"#{@home_team.name} #{@home_goals}:#{@away_goals} #{@away_team.name}"
	end

	def same_home_and_away?(home, away)
		home == @home_team and away == @away_team
	end

end