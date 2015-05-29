require_relative("league")


league = League.new("League")
league.load_teams(ARGV.shift || "teams.csv")

loop do
	puts "\nHow many matches? ('quit' to exit)"
	answer = gets.chomp.downcase
	case answer
	when /^\d+$/
		#league.play(answer.to_i)
		league.start_league
	when 'q', 'quit', 'exit'
		puts "\n"
		league.print_standings
		break
	else
		puts "Please enter a number or 'quit'"
  end
end

league.save_standings