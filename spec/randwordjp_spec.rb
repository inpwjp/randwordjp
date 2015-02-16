require 'spec_helper'

describe Randwordjp do
  it 'should have a version number' do
    expect(Randwordjp::VERSION).not_to be nil
  end

  it 'getNumeric length is should have set length' do
    expect(Randwordjp.getNumeric(15).length).to be 15
  end

  it 'getNumeric is should have numerical' do
    expect(Randwordjp.getNumeric(10)).to match /[0-9]{10}/
  end

  it 'getNumeric is not should have next time' do
    expect(Randwordjp.getNumeric(10)).not_to eq(Randwordjp.getNumeric(10))
  end

  describe "getZenkakuKatakana" do 
    it 'getZenkakuKataKana length is should have set length' do
      expect(Randwordjp.getZenkakuKataKana(15).length).to be 15
    end

    it 'getZenkakuKataKana is should have 全角カタカナ' do
      expect(Randwordjp.getZenkakuKataKana(10)).to match /[ア-ン]{10}/
    end

    it 'getZenkakuKataKana is should have ヱヰ , when the old opt is true ' do
      expect(Randwordjp.getZenkakuKataKana(5000, old: true)).to match /[ヱヰ]/
    end

    it 'getZenkakuKataKana is not have ヱヰ , when the old opt is false ' do
      expect(Randwordjp.getZenkakuKataKana(5000, old: false)).not_to match /[ヱヰ]/
    end

    it 'getZenkakuKataKana is not should have next time' do
      expect(Randwordjp.getZenkakuKataKana(10)).not_to eq(Randwordjp.getZenkakuKataKana(10))
    end
  end

  describe "getZenkakuHiraKana" do 
    it 'getZenkakuHiraKana length is should have set length' do
      expect(Randwordjp.getZenkakuHiraKana(15).length).to be 15
    end

    it 'getZenkakuHiraKana is should have 全角ひらかな' do
      expect(Randwordjp.getZenkakuHiraKana(10)).to match /[あ-ん]{10}/
    end

    it 'getZenkakuHiraKana is should have ゑゐ , when the old opt is true ' do
      expect(Randwordjp.getZenkakuHiraKana(5000, old: true)).to match /[ゑゐ]/
    end

    it 'getZenkakuKataKana is not have ゑゐ , when the old opt is false ' do
      expect(Randwordjp.getZenkakuHiraKana(5000, old: false)).not_to match /[ゑゐ]/
    end

    it 'getZenkakuHiraKana is not should have next time' do
      expect(Randwordjp.getZenkakuHiraKana(10)).not_to eq(Randwordjp.getZenkakuHiraKana(10))
    end
  end

  it 'getZenkakuAll is not should have next time' do
    expect(Randwordjp.getZenkakuAll(10)).not_to eq(Randwordjp.getZenkakuAll(10))
  end

  it 'getTodofuken is not should have next time' do
    expect(Randwordjp::getTodofuken()).not_to eq(Randwordjp::getTodofuken())
  end

  describe "getNamae" do
    it 'getNamae is not null' do
      expect(Randwordjp::getNamae()).not_to eq nil
    end

    it 'getNamae have :kana at return hash' do
      expect(Randwordjp::getNamae()[:kana]).not_to eq nil
    end

    it 'getNamae have :kanji at return hash' do
      expect(Randwordjp::getNamae()[:kanji]).not_to eq nil
    end

    it 'getNamae have :gender at return hash' do
      expect(Randwordjp::getNamae()[:gender]).not_to eq nil
    end

    it 'getNamae is not should have next time' do
      expect(Randwordjp::getNamae().to_s).not_to eq(Randwordjp::getNamae().to_s)
    end

  end

  describe "getMyoji" do
    it 'getMyoji is not null' do
      expect(Randwordjp.getMyoji).not_to eq nil
    end

    it 'getMyoji have :kana at return hash' do
      expect(Randwordjp.getMyoji[:kana]).not_to eq nil
    end

    it 'getMyoji have :kanji at return hash' do
      expect(Randwordjp.getMyoji[:kanji]).not_to eq nil
    end

    it 'getMyoji is not should have next time' do
      expect(Randwordjp.getMyoji.to_s).not_to eq(Randwordjp::getMyoji().to_s)
    end
  end
end

