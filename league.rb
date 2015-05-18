require_relative 'team'
require_relative 'match'
require 'csv'

class League

	attr_reader :title

	def initialize(title)
		@title = title.strip
		@teams = []
		@finished_matches = []
	end

	def add_team(team)
		@teams.push(team)
	end

	def print_standings
		@teams.each do |team|
			puts standings_entry(team)
		end
	end

	def load_teams(from_file)
		CSV.foreach(from_file) do |row|
			team = Team.new(row[0])
			add_team(team)
		end
	end

	def save_standings(to_file="standings.txt")
		File.open(to_file, "w") do |file|
			file.puts "#{title} Standings:"
			@teams.each do |team|
				file.puts standings_entry(team)
			end
		end
	end

	def standings_entry(team)
		name = team.name.ljust(20, ' ')
		"#{name} W#{team.wins} D#{team.draws} L#{team.loses}"
	end

	def start_league
		k = @teams.size/2
		for i in 1..k do
			u = @teams[i-1]
			v = @teams[k+i-1]
			m = random_match(u, v)
			puts m.to_s
		end
		puts finished?(Match.new(@teams[1], @teams[k], 1, 1))
	end

	def finished?(match)
		puts match
		finished = false
		@finished_matches.each do |m|
			if match.same_home_and_away?(m)
				finished = true
			end
		end
		finished
	end

	def random_match(team1, team2)
		m = Match.new(team1, team2, rand(5), rand(5))
		@finished_matches << m
		m
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

