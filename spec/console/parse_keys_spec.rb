# encoding: utf-8

require 'keyboard_magician/console/parse_key'

describe KeyboardMagician::Console::ParseKey do
  def translate(char)
    described_class.call char
  end

  it 'translates inputs that can be represented as characters to their symbol' do
    characters = [
      *'a'..'z',
      *'A'..'Z',
      *'0'..'9',
      " ",
      "'",
      *'`~!@#$%^&*()_+-=[]{}\\|;:"<>,./?œ∑´®†'.chars,
    ]

    characters.each do |char|
      expect(translate char).to eq [char.intern]
    end
  end

  it 'translates "\u007F" as :delete' do
    expect(translate "\u007F").to eq [:delete]
  end

  describe 'arrow keys' do
    it('translates \e[A as :up')    { expect(translate "\e[A").to eq [:up   ] }
    it('translates \e[B as :down')  { expect(translate "\e[B").to eq [:down ] }
    it('translates \e[C as :right') { expect(translate "\e[C").to eq [:right] }
    it('translates \e[D as :left')  { expect(translate "\e[D").to eq [:left ] }
  end

end
