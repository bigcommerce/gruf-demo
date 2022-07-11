# frozen_string_literal: true

require 'spec_helper'

describe ProductsController do
  it 'binds the service correctly' do
    expect(grpc_bound_service).to eq ::Rpc::Products::Service
  end

  describe '#get_product' do
    subject { run_rpc(:GetProduct, request_proto) }

    let(:id) { rand(1..1_000).to_i }
    let(:request_proto) { ::Rpc::GetProductReq.new(id: id) }

    context 'when the product exists' do
      let!(:product) { Product.create(name: 'test', price: 1.00) }
      let(:id) { product.id }

      it 'is successful with the product in the response' do
        expect(subject).to be_a_successful_rpc
        expect(subject.product).to be_a(::Rpc::Product)
        expect(subject.product.id).to eq product.id
        expect(subject.product.name).to eq product.name
      end
    end

    context 'when the product does not exist' do
      it 'fails with the appropriate error' do
        expect { subject }.to raise_rpc_error(GRPC::NotFound).with_serialized { |err|
          expect(err['code']).to eq 'not_found'
          expect(err['app_code']).to eq 'product_not_found'
          expect(err['message']).to eq "Failed to find Product with ID: #{id}"
        }
      end
    end
  end
end
