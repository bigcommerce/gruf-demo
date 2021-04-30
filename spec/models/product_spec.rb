# frozen_string_literal: true

require 'spec_helper'

describe Product, type: :model do
  let(:name) { Faker::Lorem.word }
  let(:product) { described_class.new(name: name) }

  describe '.to_proto' do
    subject { product.to_proto }

    it 'should return the proto' do
      expect(subject).to be_a(Rpc::Product)
      expect(subject.name).to eq name
    end
  end
end
