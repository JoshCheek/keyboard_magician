$LOAD_PATH.unshift File.expand_path '../../../lib', __FILE__

require 'keyboard_magician'

World Module.new {
  attr_writer :user_input, :target_string, :characters, :seconds_taken

  def user_input
    @user_input ||= KeyboardMagician::UserInput.new
  end

  def target_string
    @target_string || ''
  end

  def game_stats
    GameStats.new target_string: target_string,
                  input_string:  user_input.to_s,
                  seconds_taken: seconds_taken
  end

  def characters
    @characters ||= []
  end

  def output
    Output.new(target_string, user_input.to_s)
  end

  def seconds_taken
    @seconds_taken || 1
  end
}

Given 'my target is "$target_string"' do |target_string|
  self.target_string = target_string
end

Given "it takes me $time to play the game" do |raw_time|
  self.seconds_taken = raw_time.to_f
end

When "I type the characters: $character_code" do |character_code|
  self.characters += eval("[#{character_code}]").map { |cs| KeyboardMagician::Character.new *cs }
  self.user_input = KeyboardMagician::UserInput.new characters
end

Then 'the game is over' do
  expect(game_stats).to be_over
end

And 'it took me $time to play the game' do |raw_time|
  # currently expect raw_time to be a string like 5s
  expect(game_stats.seconds_taken).to eq raw_time.to_f
end

And 'my cps is $cps' do |cps|
  expect(game_stats.cps).to eq cps.to_f
end

And 'I have $n errors' do |num_errors|
  expect(game_stats.num_errors).to eq num_errors.to_i
end

Then 'the output shows:' do |table|
  expected = table.hashes.map { |h| [eval(h['character']), h['meaning'].intern] }
  expect(output.to_a).to eq expected
end

