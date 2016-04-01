require 'spec_helper_acceptance'

describe 'rancher::management' do
  context 'puppet apply' do
    it 'is expected to apply and be idempotent' do
      pp = <<-EOS
class { 'rancher::management':
  rancher_manager_port => '8080',
}
EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    context 'is expected to be running on the default port' do
      before :each do
        sleep 5 # Give it time to start.
      end

      describe command('curl 0.0.0.0:8080') do
        its(:stdout) { is_expected.to match /self.*0.0.0.0:8080/ }
      end
    end

  end
end
