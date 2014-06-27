require "spec_helper"

module Tex2png
  describe Converter do
    let(:formula)   {"\\sum_{i = 0}^{i = n} \\frac{i}{2}"}
    let(:converter) {Converter.new(formula)}

    it {expect(converter.png {|io| io}).to be_an IO}
    it {expect(converter.data).to be_a String}
  end
end
