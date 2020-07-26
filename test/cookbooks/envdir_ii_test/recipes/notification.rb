#
# Cookbook:: envdir_ii_test
# Recipe:: notification
#
# The MIT License (MIT)
#
# Copyright:: 2020, Tomoya Kabe
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

include_recipe 'envdir_ii_test::setup'

group 'testgroup' do
  gid 9999
end

user 'testuser' do
  uid 8888
  gid 'testgroup'
end

envdir_ii_envdir '/nochange' do
  values(
    'AAA' => {
      value: 'aaa',
    },
    'SSS' => {
      value: 'sss',
      sensitive: true,
    }
  )
end.run_action(:create)

envdir_ii_envdir '/nochange' do
  values(
    'AAA' => {
      value: 'aaa',
    },
    'SSS' => {
      value: 'sss',
      sensitive: true,
    }
  )
  notifies :create, 'file[nochange]'
end

envdir_ii_envdir '/dochange-content' do
  values(
    'AAA' => {
      value: 'aaa',
    },
    'SSS' => {
      value: 'sss',
      sensitive: true,
    }
  )
end.run_action(:create)

envdir_ii_envdir '/dochange-content' do
  values(
    'AAA' => {
      value: 'abc',
    },
    'SSS' => {
      value: 'sss',
      sensitive: true,
    }
  )
  notifies :create, 'file[dochange-content]'
end

envdir_ii_envdir '/dochange-owner' do
  values(
    'AAA' => {
      value: 'aaa',
    },
    'SSS' => {
      value: 'sss',
      sensitive: true,
    }
  )
end.run_action(:create)

envdir_ii_envdir '/dochange-owner' do
  owner 'testuser'
  group 'testgroup'
  values(
    'AAA' => {
      value: 'aaa',
    },
    'SSS' => {
      value: 'sss',
      sensitive: true,
    }
  )
  notifies :create, 'file[dochange-owner]'
end

envdir_ii_envdir '/dochange-add' do
  values(
    'AAA' => {
      value: 'aaa',
    },
    'SSS' => {
      value: 'sss',
      sensitive: true,
    }
  )
end.run_action(:create)

envdir_ii_envdir '/dochange-add' do
  values(
    'AAA' => {
      value: 'aaa',
    },
    'BBB' => {
      value: 'bbb',
    },
    'SSS' => {
      value: 'sss',
      sensitive: true,
    }
  )
  notifies :create, 'file[dochange-add]'
end

envdir_ii_envdir '/dochange-delete' do
  values(
    'AAA' => {
      value: 'aaa',
    },
    'SSS' => {
      value: 'sss',
      sensitive: true,
    }
  )
end.run_action(:create)

envdir_ii_envdir '/dochange-delete' do
  values(
    'AAA' => {
      value: 'aaa',
    }
  )
  notifies :create, 'file[dochange-delete]'
end

file 'nochange' do
  action :nothing
  path '/env/nochange-notified'
  content 'it should not be notified'
end

file 'dochange-content' do
  action :nothing
  path '/env/dochange-content-notified'
  content 'should be notified, by content change'
end

file 'dochange-owner' do
  action :nothing
  path '/env/dochange-owner-notified'
  content 'should be notified, by owner change'
end

file 'dochange-add' do
  action :nothing
  path '/env/dochange-add-notified'
  content 'should be notified, by addition'
end

file 'dochange-delete' do
  action :nothing
  path '/env/dochange-delete-notified'
  content 'should be notified, by deletion'
end
