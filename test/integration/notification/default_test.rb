describe file('/env/nochange-notified') do
  it { should_not exist }
end

describe file('/env/dochange-content-notified') do
  it { should exist }
end

describe file('/env/dochange-owner-notified') do
  it { should exist }
end

describe file('/env/dochange-add-notified') do
  it { should exist }
end

describe file('/env/dochange-delete-notified') do
  it { should exist }
end
