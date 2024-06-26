# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CompleteVisibleOrdersQuery do
  subject(:result) { described_class.new(order_permissions).call }

  let(:filter_canceled) { false }

  describe '#call' do
    let(:user) { create(:user) }
    let(:enterprise) { create(:enterprise) }
    let(:order_permissions) { Permissions::Order.new(user, filter_canceled) }

    before do
      user.enterprises << enterprise
      user.save!
    end

    context 'when an order has no completed_at' do
      let(:cart_order) { create(:order, distributor: enterprise) }

      it 'does not return it' do
        expect(result).not_to include(cart_order)
      end
    end

    context 'when an order has complete_at' do
      let(:complete_order) { create(:order, completed_at: 1.day.ago, distributor: enterprise) }

      it 'does not return it' do
        expect(result).to include(complete_order)
      end
    end

    it 'calls #visible_orders' do
      expect(order_permissions).to receive(:visible_orders).and_call_original
      result
    end
  end
end
