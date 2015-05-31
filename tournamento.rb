require_relative("league")


league = League.new("League")
league.load_teams(ARGV.shift || "teams.csv")

league.start_league

league.print_standings

league.save_standings