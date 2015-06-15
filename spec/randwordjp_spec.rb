# coding: utf-8
require 'spec_helper'

describe Randwordjp do
  it 'should have a version number' do
    expect(Randwordjp::VERSION).not_to be nil
  end

  it 'numeric length is should have set length' do
    expect(Randwordjp.numeric(15).length).to be 15
  end

  it 'numeric is should have numerical' do
    expect(Randwordjp.numeric(10)).to match(/[0-9]{10}/)
  end

  it 'numeric is not should have next time' do
    expect(Randwordjp.numeric(10)).not_to eq(Randwordjp.numeric(10))
  end

  it 'mail_address is not nil' do
    expect(Randwordjp.mail_address).not_to be nil
  end

  describe 'zenkaku_katakana' do
    it 'zenkaku_katakana length is should have set length' do
      expect(Randwordjp.zenkaku_katakana(15).length).to be 15
    end

    it 'zenkaku_katakana is should have 全角カタカナ' do
      expect(Randwordjp.zenkaku_katakana(10)).to match(/[ア-ン]{10}/)
    end

    it 'zenkaku_katakana is should have ヱヰ , when the old opt is true ' do
      expect(Randwordjp.zenkaku_katakana(5000, old: true)).to match(/[ヱヰ]/)
    end

    it 'zenkaku_katakana is not have ヱヰ , when the old opt is false ' do
      expect(Randwordjp.zenkaku_katakana(5000, old: false)).not_to match(/[ヱヰ]/)
    end

    it 'zenkaku_katakana is not should have next time' do
      expect(Randwordjp.zenkaku_katakana(10)).not_to eq(Randwordjp.zenkaku_katakana(10))
    end
  end

  describe 'zenkaku_hirakana' do
    it 'zenkaku_hirakana length is should have set length' do
      expect(Randwordjp.zenkaku_hirakana(15).length).to be 15
    end

    it 'zenkaku_hirakana is should have 全角ひらかな' do
      expect(Randwordjp.zenkaku_hirakana(10)).to match(/[あ-ん]{10}/)
    end

    it 'zenkaku_hirakana is should have ゑゐ , when the old opt is true ' do
      expect(Randwordjp.zenkaku_hirakana(5000, old: true)).to match(/[ゑゐ]/)
    end

    it 'zenkaku_hirakana is not have ゑゐ , when the old opt is false ' do
      expect(Randwordjp.zenkaku_hirakana(5000, old: false)).not_to match(/[ゑゐ]/)
    end

    it 'zenkaku_hirakana is not should have next time' do
      expect(Randwordjp.zenkaku_hirakana(10)).not_to eq(Randwordjp.zenkaku_hirakana(10))
    end
  end

  it 'zenkaku_all is not should have next time' do
    expect(Randwordjp.zenkaku_all(10)).not_to eq(Randwordjp.zenkaku_all(10))
  end

  it 'todofuken is not should have next time' do
    expect(Randwordjp.todofuken).not_to eq(Randwordjp.todofuken)
  end

  describe 'namae' do
    it 'namae is not null' do
      expect(Randwordjp.namae).not_to eq nil
    end

    it 'only male data' do
      expect(Randwordjp.namae(only: :male)).not_to eq nil
    end

    it 'only female data' do
      expect(Randwordjp.namae(only: :female)).not_to eq nil
    end

    it 'namae have :kana at return hash' do
      expect(Randwordjp.namae[:kana]).not_to eq nil
    end

    it 'namae have :kanji at return hash' do
      expect(Randwordjp.namae[:kanji]).not_to eq nil
    end

    it 'namae have :gender at return hash' do
      expect(Randwordjp.namae[:gender]).not_to eq nil
    end

    it 'namae is not should have next time' do
      expect(Randwordjp.namae.to_s).not_to eq(Randwordjp.namae.to_s)
    end
  end

  describe 'myoji' do
    it 'myoji is not null' do
      expect(Randwordjp.myoji).not_to eq nil
    end

    it 'myoji have :kana at return hash' do
      expect(Randwordjp.myoji[:kana]).not_to eq nil
    end

    it 'myoji have :kanji at return hash' do
      expect(Randwordjp.myoji[:kanji]).not_to eq nil
    end

    it 'myoji is not should have next time' do
      expect(Randwordjp.myoji.to_s).not_to eq(Randwordjp.myoji.to_s)
    end
  end

  describe 'zip code' do 
    it 'zip is should have numeric which is length 7 ' do
      expect(Randwordjp.zip).to match(/[0-9]{7}/)
    end

    it 'zip is should have numeric which is [0-9]{3}-[0-9]{4} , when hyphen is true' do
      expect(Randwordjp.zip(hyphen: true)).to match(/[0-9]{3}-[0-9]{4}/)
    end

    it 'zip is not should have next time' do
      expect(Randwordjp.zip).not_to eq(Randwordjp.zip)
    end
  end

  describe 'address' do 
    it 'address is not should have next time' do
      expect(Randwordjp.address).not_to eq(Randwordjp.address)
    end
  end
end
