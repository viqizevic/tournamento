require_relative("league")


league = League.new("Serie A")
league.load_teams(ARGV.shift || "teams.csv")

loop do
	puts "\nHow many matches? ('quit' to exit)"
	answer = gets.chomp.downcase
	case answer
	when /^\d+$/
		#league.play(answer.to_i)
	when 'q', 'quit', 'exit'
		league.print_teams
		break
	else
		puts "Please enter a number or 'quit'"
  end
end