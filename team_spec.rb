require_relative 'team'
require_relative 'match'

describe Team do

	before do
		@lazio = Team.new(' Lazio ')
	end

	it "has a striped name" do
		expect(@lazio.name).to eq('Lazio')
	end

	it "has no initial numbers of stats" do
		expect(@lazio.wins).to eq(0)
		expect(@lazio.draws).to eq(0)
		expect(@lazio.loses).to eq(0)
	end

	it "increases number of wins by 1 if win one game" do
		@lazio.win_one_game
		expect(@lazio.wins).to eq(1)
		expect(@lazio.draws).to eq(0)
		expect(@lazio.loses).to eq(0)
	end

	it "increases number of loses by 1 if lose one game" do
		@lazio.lose_one_game
		expect(@lazio.wins).to eq(0)
		expect(@lazio.draws).to eq(0)
		expect(@lazio.loses).to eq(1)
	end

	it "increases number of draws by 1 if play draw one game" do
		@lazio.play_draw
		expect(@lazio.wins).to eq(0)
		expect(@lazio.draws).to eq(1)
		expect(@lazio.loses).to eq(0)
	end

	it "has no matches at all initially" do
		expect(@lazio.matches.size).to eq(0)
	end

	it "saves matches" do
		juve = Team.new("Juve")
		Match.new(@lazio, juve, 2, 0)
		Match.new(juve, @lazio, 0, 1)
		expect(@lazio.matches.size).to eq(2)
	end
	
end