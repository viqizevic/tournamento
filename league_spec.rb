require_relative 'league'

describe League do

	before do
		lazio = Team.new('Lazio')
		juve = Team.new('Juve')
		@teams = [lazio, juve]
		
		@league = League.new('Serie A')
		@teams.each do |t|
			@league.add_team(t)
		end
	end

	it "has no teams at all initially" do
		@league = League.new('Empty')
		expect(@league.teams.size).to eq(0)
	end

	it "has the added teams" do
		expect(@league.teams.size > 0).to be_truthy
		expect(@league.teams.size).to eq(@teams.size)
	end

	it "has no matches at all initially" do
		expect(@league.finished_matches.size).to eq(0)
	end

	it "has correct number of matches after start" do
		@league.start_league
		expect(@league.finished_matches.size).to eq(2)
	end

end