$LOAD_PATH.unshift File.expand_path '../../../lib', __FILE__

require 'keyboard_magician'

World Module.new {
  attr_writer :user_input, :target_string, :keys, :seconds_taken

  def user_input
    @user_input ||= KeyboardMagician::UserInput.new
  end

  def target_string
    @target_string || ''
  end

  def trick_stats
    KeyboardMagician::TrickStats.new target_string: target_string,
                                     input_string:  user_input.to_s,
                                     seconds_taken: seconds_taken
  end

  def keys
    @keys ||= []
  end

  def seconds_taken
    @seconds_taken || 1
  end
}

Given 'my target is "$target_string"' do |target_string|
  self.target_string = target_string
end

Given "it takes me $time to perform the trick" do |raw_time|
  # currently expect raw_time to be a string like 5s
  self.seconds_taken = raw_time.to_f
end

Then 'it took me $time to perform the trick' do |raw_time|
  # currently expect raw_time to be a string like 5s
  expect(trick_stats.seconds_taken).to eq raw_time.to_f
end

When "I press the keys: $key_code" do |key_code|
  self.keys += eval("[#{key_code}]").map { |cs| KeyboardMagician::Key.new *cs }
  self.user_input = KeyboardMagician::UserInput.new keys
end

Then 'the trick is over' do
  expect(trick_stats).to be_over
end

Then 'my cps is $cps' do |cps|
  expect(trick_stats.cps).to eq cps.to_f
end

Then 'my wpm is $wpm' do |wpm|
  expect(trick_stats.wpm).to eq wpm.to_f
end

Then 'I have $n errors' do |num_errors|
  expect(trick_stats.num_errors).to eq num_errors.to_i
end

Then 'the output shows:' do |table|
  expected = table.hashes.map { |h| [eval(h['character']), h['result'].intern] }
  progress = KeyboardMagician::Progress.call(target_string, user_input.to_s)
  expect(progress).to eq expected
end
