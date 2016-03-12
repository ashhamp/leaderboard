require 'spec_helper'

RSpec.describe Leaderboard do

  let(:leaderboard) { Leaderboard.new }

  describe ".new" do
    it "should be a Leaderboard class" do
      expect(leaderboard).to be_a(Leaderboard)
    end

    it "should have an optional game data attribute" do
      test_game_data = [
        {
          home_team: "Patriots",
          away_team: "Ravens",
          home_score: 30,
          away_score: 15
        },
        {
          home_team: "Some Football Team",
          away_team: "Other Team",
          home_score: 3,
          away_score: 21
        }
      ]
      result = Leaderboard.new(test_game_data)
      expect(result).to be_a(Leaderboard)
    end

    it "should have a teams attribute that is an empty array" do
      expect(leaderboard.teams).to eq([])
    end
  end

  describe "#add_teams" do
    it "adds teams as Team object to the teams instance" do
      leaderboard.add_teams
      expect(leaderboard.teams.first).to be_a(Team)
    end
  end

  describe "#add_wins_and_losses" do
    it "adds the number of wins and losses to each Team object in teams" do
      leaderboard.add_teams
      leaderboard.add_wins_and_losses

      expect(leaderboard.teams.first.wins).to eq(3)
      expect(leaderboard.teams[1].losses).to eq(2)
    end
  end

  describe "#set_ranks" do
    it "sorts teams by wins and sets their ranks" do
      leaderboard.add_teams
      leaderboard.add_wins_and_losses
      leaderboard.set_ranks

      result = leaderboard.teams.first.rank
      expect(result).to eq(1)

      result = leaderboard.teams.last.rank
      expect(result).to eq(leaderboard.teams.size)

      result = leaderboard.teams[2]
      expect(result.name).to eq("Broncos")
    end
  end

  describe "#display" do
    it "prints leaderboard to terminal" do
      leaderboard.add_teams
      leaderboard.add_wins_and_losses
      leaderboard.set_ranks

      board =
      "------------------------------------------------\n" +
        "| Name       Rank   Total Wins   Total Losses  |\n" +
        "| Patriots   1      3            0             |\n" +
        "| Steelers   2      1            1             |\n" +
        "| Broncos    3      1            2             |\n" +
        "| Colts      4      0            2             |\n" +
        "------------------------------------------------\n"

      expect { leaderboard.display }.to output(board).to_stdout
    end
  end

  describe "#team_game_summary" do
    it "takes Team object as parameter, prints out info about team's games" do
      leaderboard.add_teams
      leaderboard.add_wins_and_losses
      leaderboard.set_ranks

      sum =
      "Patriots played 3 game(s).\n" +
      "They played as the home team against the Broncos and won: 17 to 13.\n" + "They played as the home team against the Colts and won: 21 to 17.\n" + "They played as the away team against the Steelers and won: 31 to 24.\n"

      expect do
        leaderboard.team_game_summary(leaderboard.teams.first)
      end.to output(sum).to_stdout
    end
  end
end
  1) Blackjack.ne
