require "spec_helper"

module Tex2png
  describe Command do
    let(:sym1)  {:ruby}
    let(:sym2)  {:a2f39sdY}
    let(:cmd1)  {Command.new(sym1)}
    let(:cmd2)  {Command.new(sym2)}
    let(:dummy) {"./spec/support/dummy.rb"}
    let(:arg1)  {"dummy!"}
    let(:arg2)  {"yummy!"}

    context "when cmd exist" do
      subject {cmd1}

      it {is_expected.to be_a Command}

      describe Result  do
        let(:res1) {cmd1.run([dummy, arg1])}
        let(:res2) {cmd1.run([dummy, arg2])}

        it {expect(res2).to be_a Result}

        context "when cmd succeeds" do
          it {expect(res1).to be_a Result}
          it {expect(res1.success?).to be true}
          it {expect(res1.output).to be_empty}
        end

        context "when cmd fails" do
          it {expect(res2).to be_a Result}
          it {expect(res2.success?).to be false}
          it {expect(res2.output).to eq "failed!\n"}
        end
      end
    end

    context "when cmd not exist" do
      it {expect{cmd2}.to raise_error(CommandNotFound, sym2.to_s)}
    end
  end
end
