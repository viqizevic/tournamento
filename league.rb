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
		s = standings_entry("Team", "G", "W", "D", "L", "P") + "\n"
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
		standings_entry(team.name, team.number_of_games, team.wins, team.draws, team.loses, team.points)
	end

	def standings_entry(name, g, w, d, l, p)
		name = name.ljust(20, ' ')
		g = "#{g}".rjust(3, ' ')
		w = "#{w}".rjust(3, ' ')
		d = "#{d}".rjust(3, ' ')
		l = "#{l}".rjust(3, ' ')
		p = "#{p}".rjust(4, ' ')
		"#{name} #{g} #{w} #{d} #{l} #{p}"
	end

	def start_league
		n_matches_pro_matchday = @teams.size/2
		n_matchdays = 2 * (@teams.size - 1)
		groups = @teams.clone
		for i in 1..n_matchdays do
			matchday_matches = []
			played_teams = []
			puts "Matchday #{i}"
			groups.each do |u|
				if matchday_matches.size >= n_matches_pro_matchday
					break
				end
				groups.each do |v|
					if u != v and not played_teams.include?(u.name) and not played_teams.include?(v.name)
						if not finished_match?(u, v)
							m = random_match(u, v)
							puts m
							matchday_matches << m
							played_teams << u.name
							played_teams << v.name
						end
					end
				end
			end
			t = groups.shift
			groups << t
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

