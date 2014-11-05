require 'spec_helper'

describe Randwordjp do
  it 'should have a version number' do
    expect(Randwordjp::VERSION).not_to be nil
  end

  it 'getNumerical is should have numerical' do
    Randwordjp::getNumerical(10).should =~ /[0-9]{10}/
  end

# 'should do something useful' do
#     expect(false).to eq(true)
#   end
end

