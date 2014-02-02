require 'keyboard_magician/console/screen_progress'

describe KeyboardMagician::Console::ScreenProgress do
  def call(progress_ary)
    described_class.call progress_ary
  end

  it 'converts correct into black on green' do
    expect(call([['a', :correct]])).to eq "\e[30;42ma"
  end

  it 'converts incorrect into white on red' do
    expect(call([['a', :incorrect]])).to eq "\e[37;41ma"
  end

  it 'converts everything else into default colouring' do
    expect(call([['a', :unattempted]])).to eq "\e[0ma"
  end

  it 'colours each character' do
    expect(call([['a', :correct], ['b', :unattempted]])).to eq "\e[30;42ma\e[0mb"
  end
end
