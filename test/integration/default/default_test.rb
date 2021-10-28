describe directory('/env/default') do
  it { should exist }
  its('mode') { should eq 0755 }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
end

describe file('/env/default/AAA') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('content') { should eq 'aaa' }
  its('mode') { should eq 0644 }
end

describe file('/env/default/SSS') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('content') { should eq 'sss' }
  its('mode') { should eq 0600 }
end

describe file('/env/default/INT') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('content') { should eq '1' }
  its('mode') { should eq 0644 }
end

describe file('/env/default/BOOL') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('content') { should eq 'true' }
  its('mode') { should eq 0644 }
end

describe file('/env/default/DDD') do
  it { should_not exist }
end
