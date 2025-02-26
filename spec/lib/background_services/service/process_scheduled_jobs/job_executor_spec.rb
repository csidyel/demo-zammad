# Copyright (C) 2012-2025 Zammad Foundation, https://zammad-foundation.org/

require 'rails_helper'

RSpec.describe BackgroundServices::Service::ProcessScheduledJobs::JobExecutor, ensure_threads_exited: true do

  describe '.run' do
    let(:backend_instance) { backend.new(job) }

    shared_examples 'verify job dispatching' do
      before do
        allow(backend).to receive(:new).and_return(backend_instance)
        allow(backend_instance).to receive(:run).and_return(true)
      end

      it 'dispatches to the right back end' do
        described_class.run(job)
        expect(backend_instance).to have_received(:run)
      end

      context 'when shutdown is requested' do
        before do
          allow(BackgroundServices).to receive(:shutdown_requested).and_return(true)
        end

        it 'does not start the job' do
          described_class.run(job)
          expect(backend_instance).not_to have_received(:run)
        end
      end
    end

    context 'with one-time jobs' do
      let(:job) { create(:scheduler, active: true, period: 10.minutes, method: 'true') }
      let(:backend) { BackgroundServices::Service::ProcessScheduledJobs::JobExecutor::OneTime }

      it_behaves_like 'verify job dispatching'
    end

    context 'with continuous jobs' do
      let(:job) { create(:scheduler, active: true, period: 5.minutes, method: 'true') }
      let(:backend) { BackgroundServices::Service::ProcessScheduledJobs::JobExecutor::Continuous }

      it_behaves_like 'verify job dispatching'
    end
  end
end
