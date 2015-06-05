require_relative("league")


league = League.new("League")
league.load_teams(ARGV.shift || "teams.csv")

puts league.team_names

loop do
    puts "\nWhat should be done, (1) print plan or (2) start league? ('quit' to exit)"
    answer = gets.chomp.downcase
    case answer
    when '1'
    	league.print_fixture_plan
        league.save_fixture_plan
    when '2'
		league.start_league
    when 'quit', 'exit', 'q'
		league.print_standings
		league.save_standings
        break
    else
        puts "Please enter your choice: (1) print plan or (2) start league or 'quit'"
    end
end
