require_relative '../spec/spec_helper'

class Leaderboard
  attr_reader :game_data, :teams

  GAME_INFO = [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 17,
      away_score: 13
    },
    {
      home_team: "Broncos",
      away_team: "Colts",
      home_score: 24,
      away_score: 7
    },
    {
      home_team: "Patriots",
      away_team: "Colts",
      home_score: 21,
      away_score: 17
    },
    {
      home_team: "Broncos",
      away_team: "Steelers",
      home_score: 11,
      away_score: 27
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 24,
      away_score: 31
    }
  ]

  # YOUR CODE GOES HERE
  def initialize(game_data = GAME_INFO)
    @game_data = game_data
    @teams = []
  end

  def add_teams
    @game_data.each do |game|
      team_home = @teams.find { |t| t.name == game[:home_team] }
      team_away = @teams.find { |t| t.name == game[:away_team] }

      if team_home.nil?
        team_home = Team.new(game[:home_team])
        @teams << team_home
      end

      if team_away.nil?
        team_away = Team.new(game[:away_team])
        @teams << team_away
      end
    end
    puts "teams added!"
  end

  def add_wins_and_losses
    @teams.each do |team|
      games_home = @game_data.select { |game| game[:home_team] == team.name }
      games_home.each do |game|
        if game[:home_score] > game[:away_score]
          team.wins += 1
        else
          team.losses += 1
        end
      end
      games_away = @game_data.select { |game| game[:away_team] == team.name }
      games_away.each do |game|
        if game[:away_score] > game[:home_score]
          team.wins += 1
        else
          team.losses += 1
        end
      end
    end
    puts "wins and losses added!"
  end

  def set_ranks
    @teams.sort_by! { |team| [-team.wins, team.losses] }
    @teams.each_with_index do |team, index|
      team.rank = index + 1
    end
    puts "ranks set!"
  end

  def display
    display_print = ""

    header = format(
      "|\s%-11s%-7s%-13s%-13s\s|\n",
      "Name",
      "Rank",
      "Total Wins",
      "Total Losses"
    )

    border = "-" * (header.size - 1) + "\n"

    display_print << border + header

    @teams.each do |team|
      line = format(
        "|\s%-11s%-7d%-13d%-13d\s|\n",
        "#{team.name}",
        team.rank,
        team.wins,
        team.losses
      )

      display_print << line
    end
    display_print << border
    print display_print
  end

  def team_game_summary(team_obj)
    total_games = team_obj.wins + team_obj.losses

    sum = "#{team_obj.name} played #{total_games} game(s).\n"

    games_home = @game_data.select { |game| game[:home_team] == team_obj.name }
    games_home.each do |game|
      sum << "They played as the home team against the #{game[:away_team]}"
      if game[:home_score] > game[:away_score]
        sum << " and won: "
      else
        sum << " and lost: "
      end
      sum << "#{game[:home_score]} to #{game[:away_score]}.\n"
    end
    games_away = @game_data.select { |game| game[:away_team] == team_obj.name }
    games_away.each do |game|
      sum << "They played as the away team against the #{game[:home_team]}"
      if game[:home_score] > game[:away_score]
        sum << " and lost: "
      else
        sum << " and won: "
      end
      sum << "#{game[:away_score]} to #{game[:home_score]}.\n"
    end
    print sum
  end
end
