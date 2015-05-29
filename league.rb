require_relative 'team'
require_relative 'match'
require 'csv'

class League

	attr_reader :title, :teams, :finished_matches

	def initialize(title)
		@title = title.strip
		# TODO: need a hash map actually for the teams
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
		n_matches_pro_matchday = @teams.size/2
		n_matchdays = 2 * (@teams.size - 1)
		for i in 1..n_matchdays do
			matchday_matches = []
			@teams.each do |u|
				if matchday_matches.size >= n_matches_pro_matchday
					break
				end
				@teams.each do |v|
					if u != v
						if not finished_match?(u, v)
							m = random_match(u, v)
							puts m
							matchday_matches << m
						end
					end
				end
			end
		end
	end

	def finished_match?(home, away)
		finished = false
		@finished_matches.each do |match|
			if match.same_home_and_away?(home, away)
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

