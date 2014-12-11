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

  it 'getZenkakuKataKana length is should have set length' do
    expect(Randwordjp.getZenkakuKataKana(15).length).to be 15
  end

  it 'getZenkakuKataKana is should have 全角カタカナ' do
    expect(Randwordjp.getZenkakuKataKana(10)).to match /[ア-ヲ]{10}/
  end

  it 'getZenkakuKataKana is not should have next time' do
    expect(Randwordjp.getZenkakuKataKana(10)).not_to eq(Randwordjp.getZenkakuKataKana(10))
  end

  it 'getTodofuken is not should have next time' do
    expect(Randwordjp::getTodofuken()).not_to eq(Randwordjp::getTodofuken())
  end
end

