require 'spec_helper_acceptance'

describe 'rancher::management' do
  context 'puppet apply' do

    if ENV['HAS_JOSH_K_SEAL_OF_APPROVAL'] do
      it 'run docker code first for traivs issues' do
        pp <<-EOS
        include docker
        EOS
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes => true)
      end

      it 'is expected to apply and be idempotent' do
        pp = <<-EOS
        class { 'rancher::management':
          rancher_manager_port => '8080',
        }
        EOS

        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes => true)
      end
    end

    describe command('journalctl -u docker.service') do
      it {
        expect(subject.stdout).to match /SHOW ME THE LOGS/
      }
    end

    describe docker_image('rancher/server') do
      it { is_expected.to exist }
    end

    describe command('curl 0.0.0.0:8080') do
      it {
      sleep 60 # Give Rancher time to start.
      expect(subject.stdout).to match /self.*0.0.0.0:8080/
    }
  end
end
