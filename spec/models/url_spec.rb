require 'rails_helper'

RSpec.describe Url, type: :model do
  # Private methods
  describe '#generate_shortened' do
    it 'generates a random string' do
      url = Url.new(original: 'https://www.google.com/')

      expect(url.send(:generate_shortened!)).to be_a(String)
    end

    it 'generates a random string of length 6' do
      url = Url.new(original: 'https://www.google.com/')

      expect(url.send(:generate_shortened!).length).to eq(6)
    end
  end

  describe '#format_original!' do
    it 'adds http:// to original if it is missing' do
      url = Url.new(original: 'www.google.com')

      url.send(:format_original!)

      expect(url.original).to eq('http://www.google.com')
    end

    it 'does not add http:// to original if http:// present' do
      url = Url.new(original: 'http://www.google.com')

      url.send(:format_original!)

      expect(url.original).to eq('http://www.google.com')
    end

    it 'does not add http:// to original if https:// present' do
      url = Url.new(original: 'https://www.google.com')

      url.send(:format_original!)

      expect(url.original).to eq('https://www.google.com')
    end
  end
end
