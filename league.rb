require_relative 'team'
require_relative 'match'

class League

	attr_reader :title

	def initialize(title)
		@title = title
		@teams = []
	end

	def add_team(team)
		@teams.push(team)
	end

	def print_teams
		@teams.each do |team|
			puts team
		end
	end

end


if __FILE__ == $0
	lazio = Team.new('Lazio')
	
	juve = Team.new('Juventus')
	
	teams = [lazio, juve]
	
	m = Match.new(lazio, juve, 2, 0)
	
	l = League.new('Serie A')
	l.add_team(lazio)
	l.add_team(juve)
	l.print_teams
end

