require 'spec_helper'

describe Worthwhile::LeaseService do
  let(:future_date) { 2.days.from_now }
  let(:past_date) { 2.days.ago }

  let!(:work_with_expired_lease1) do
    FactoryGirl.build(:generic_work, lease_expiration_date: past_date.to_s).tap do |work|
      work.save(validate: false)
    end
  end

  let!(:work_with_expired_lease2) do
    FactoryGirl.build(:generic_work, lease_expiration_date: past_date.to_s).tap do |work|
      work.save(validate: false)
    end
  end

  let!(:work_with_lease_in_effect) { FactoryGirl.create(:generic_work, lease_expiration_date: future_date.to_s)}
  let!(:work_without_lease) { FactoryGirl.create(:generic_work)}

  describe "#assets_with_expired_leases" do
    it "returns an array of assets with expired embargoes" do
      returned_pids = subject.assets_with_expired_leases.map {|a| a.pid}
      expect(returned_pids).to include work_with_expired_lease1.pid,work_with_expired_lease2.pid
      expect(returned_pids).to_not include work_with_lease_in_effect.pid,work_without_lease.pid
    end
  end

  describe "#assets_under_lease" do
    it "returns an array of assets with expired embargoes" do
      returned_pids = subject.assets_under_lease.map {|a| a.pid}
      expect(returned_pids).to include work_with_expired_lease1.pid,work_with_expired_lease2.pid,work_with_lease_in_effect.pid
      expect(returned_pids).to_not include work_without_lease.pid
    end
  end
end
