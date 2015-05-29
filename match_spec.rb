require_relative 'match'
require_relative 'team'

describe Match do

	before do
		@lazio = Team.new('Lazio')
		@juve = Team.new('Juve')
	end

	it "ends with home team victory" do
		match = Match.new(@lazio, @juve, 1, 0)
		expect(@lazio.wins).to eq(1)
		expect(@lazio.draws).to eq(0)
		expect(@lazio.loses).to eq(0)
		expect(@juve.wins).to eq(0)
		expect(@juve.draws).to eq(0)
		expect(@juve.loses).to eq(1)
	end

	it "ends with away team victory" do
		match = Match.new(@juve, @lazio, 0, 1)
		expect(@lazio.wins).to eq(1)
		expect(@lazio.draws).to eq(0)
		expect(@lazio.loses).to eq(0)
		expect(@juve.wins).to eq(0)
		expect(@juve.draws).to eq(0)
		expect(@juve.loses).to eq(1)
	end

	it "ends with no victory" do
		match = Match.new(@juve, @lazio, 1, 1)
		expect(@lazio.wins).to eq(0)
		expect(@lazio.draws).to eq(1)
		expect(@lazio.loses).to eq(0)
		expect(@juve.wins).to eq(0)
		expect(@juve.draws).to eq(1)
		expect(@juve.loses).to eq(0)
	end

	it "has correct method to check matches with same constellation" do
		m1 = Match.new(@juve, @lazio, 1, 1)
		m2 = Match.new(@juve, @lazio, 0, 1)
		expect(m1.same_home_and_away?(@juve, @lazio)).to be_truthy
		expect(m2.same_home_and_away?(@juve, @lazio)).to be_truthy

		m3 = Match.new(@lazio, @juve, 1, 0)
		expect(m1.same_home_and_away?(@lazio, @juve)).to be_falsey
		expect(m2.same_home_and_away?(@lazio, @juve)).to be_falsey
	end

end