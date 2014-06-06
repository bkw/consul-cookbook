require 'spec_helper'

describe service('consul') do
  it { should be_enabled }
  it { should be_running }
end

[8300, 8400, 8500, 8600].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command "consul info | grep -A4 '^consul:'" do
  it { should return_exit_status 0 }
  it { should return_stdout /bootstrap = false/ }
  it { should return_stdout /leader = false/ }
  it { should return_stdout /server = true/ }
end


