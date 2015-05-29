require_relative 'team'
require_relative 'match'
require 'csv'

class League

	attr_reader :title, :teams, :finished_matches

	def initialize(title)
		@title = title.strip
		@teams = []
		@finished_matches = []
	end

	def add_team(team)
		@teams.push(team)
	end

	def standings
		s = standings_entry("Team", "W", "D", "L") + "\n"
		@teams.each do |team|
			s += standings_team_entry(team) + "\n"
		end
		s
	end

	def print_standings
		puts "Table #{title}"
		puts standings
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
			file.puts standings
		end
	end

	def standings_team_entry(team)
		standings_entry(team.name, team.wins, team.draws, team.loses)
	end

	def standings_entry(name, w, d, l)
		name = name.ljust(20, ' ')
		w = "#{w}".rjust(3, ' ')
		d = "#{d}".rjust(3, ' ')
		l = "#{l}".rjust(3, ' ')
		"#{name} #{w} #{d} #{l}"
	end

	def start_league
		k = @teams.size/2
		for i in 1..k do
			u = @teams[i-1]
			v = @teams[k+i-1]
			m = random_match(u, v)
		end
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
	
	l = League.new('Serie A')
	teams.each do |t|
		l.add_team(t)
	end

	l.start_league
	l.print_standings
end

