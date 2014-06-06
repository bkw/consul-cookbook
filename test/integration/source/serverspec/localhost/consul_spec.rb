require 'spec_helper'

describe command('which consul') do
  it { should return_exit_status 0 }
  it { should return_stdout /\/usr\/local\/bin\/consul/ }
end

describe service('consul') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/consul.d') do
  it { should be_directory }
end

describe file('/var/lib/consul') do
  it { should be_directory }
end

[8300, 8400, 8500, 8600].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command "consul members" do
  it { should return_exit_status 0 }
  it { should return_stdout /\balive\b/ }
  it { should return_stdout /\brole=consul\b/ }
  it { should return_stdout /\bbootstrap=1\b/ }
end
