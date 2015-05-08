require_relative 'team'

describe Team do

	before do
		@lazio = Team.new('lazio')
	end

	it "has a capitalized name" do
		expect(@lazio.name).to eq('Lazio')
	end

	it "has no initial numbers of stats" do
		expect(@lazio.wins).to eq(0)
		expect(@lazio.draws).to eq(0)
		expect(@lazio.loses).to eq(0)
	end

	it "increases wins by 1 if win one game" do
		@lazio.win_one_game
		expect(@lazio.wins).to eq(1)
	end
	
end