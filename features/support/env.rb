$LOAD_PATH.unshift File.expand_path '../../../lib', __FILE__

require 'tutor'

World Module.new {
  attr_writer :game, :timer
  def game
    @game || raise("Accessing game before setting it")
  end

  def timer
    @timer || MockTimer.new(1)
  end

  def game_stats
    GameStats.new(game: game, timer: timer)
  end
}

Given "I'm playing a simple game" do
  self.game = Game.new
end

Given 'my target is "$target_string"' do |target_string|
  game.target_string = target_string
end

Given "it takes me $time to play the game" do |raw_time|
  self.timer = MockTimer.new raw_time.to_f
end

When "I type the characters: $character_code" do |character_code|
  characters = eval("[#{character_code}]")
                 .map { |cs| Character.new *cs }

  characters.each do |character|
    self.game = game.user_enters character
  end
end

Then 'the game is over' do
  expect(game_stats).to be_over
end

And 'it took me $time to play the game' do |raw_time|
  # currently expect raw_time to be a string like 5s
  expect(game_stats.time_taken).to eq raw_time.to_f
end

And 'my cps is $cps' do |cps|
  expect(game_stats.cps).to eq cps.to_f
end

And 'I have $n errors' do |num_errors|
  expect(game_stats.num_errors).to eq num_errors.to_i
end
