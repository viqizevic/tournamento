require_relative 'team'
require_relative 'match'
require 'csv'

class League

	attr_reader :title, :finished_matches

	def initialize(title)
		@title = title.strip
		@teams = Hash.new
		@finished_matches = []
	end

	def team_names
		@teams.keys
	end

	def teams
		@teams.values
	end

	def add_team(team)
		@teams[team.name] = team
	end

	def standings
		s = standings_entry("Team", "G", "W", "D", "L", "P") + "\n"
		sorted = teams.sort { |a, b| b.points <=> a.points }
		sorted.each do |team|
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
		fixture_plan.each do |day, matches|
			puts "\nMatchday #{day}"
			matches.each do |match|
				u = match[:home]
				v = match[:away]
				if finished_match?(u, v)
					puts "Cannot play the match #{u.name} vs #{v.name} again!"
				else
					m = random_match(u, v)
					puts m
				end
			end
		end
	end

	def print_fixture_plan
		fixture_plan.each do |day, matches|
			puts "\nMatchday #{day}"
			matches.each do |match|
				u = match[:home]
				v = match[:away]
				l = 10
				h = u.name.ljust(l, ' ')
				a = v.name.rjust(l, ' ')
				if finished_match?(u, v)
					puts "Finished: #{h} vs #{a}"
				else
					puts "#{h} vs #{a}"
				end
			end
		end
	end

	def fixture_plan
		plan = Hash.new
		n_teams = @teams.size
		n_matchdays = 2*(n_teams-1)
		group = teams
		fix = group.shift
		top = group.shift
		first_group = []
		second_group = []
		group_size = group.size/2
		for i in 1..group_size do
			first_group << group.shift
			second_group << group.shift
		end
		for i in 1..n_matchdays do
			matches = []
			m = { home: top, away: fix }
			if i.odd?
				m = { home: fix, away: top }
			end
			matches << m
			for j in 0..first_group.size-1 do
				u = first_group[j]
				v = second_group[j]
				m = { home: u, away: v }
				switch = j.even?
				if i > n_matchdays/2
					switch = j.odd?
				end
				if switch
					m = { home: v, away: u }
				end
				matches << m
			end
			second_group.unshift(top)
			first_group << second_group.pop
			top = first_group.shift
			plan[i] = matches
		end
		plan
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

