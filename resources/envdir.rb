property :path, String, name_property: true
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :values, Hash, default: {}

unified_mode true

default_action :create

load_current_value do |new_resource|
  owner new_resource.owner
  group new_resource.group
  current_value_does_not_exist! unless Dir.exist?(new_resource.path)

  path = new_resource.path
  values(
    Dir.each_child(path).select { |e| ::File.file?("#{path}/#{e}") }.each_with_object({}) do |e, h|
      file = ::File.open("#{path}/#{e}")
      content = file.read
      sensitive = file.stat.mode & 0o4
      h[e] = {
        value: content,
        sensitive: sensitive,
      }
    end
  )
end

action :create do
  directory new_resource.path do
    owner new_resource.owner
    group new_resource.group
    mode '0755'
  end

  if @current_resource
    (@current_resource.values.keys - new_resource.values.keys).each do |e|
      file "#{new_resource.path}/#{e}" do
        action :delete
      end
    end
  end

  new_resource.values.each do |e, v| # rubocop:disable Style/HashEachMethods
    file "#{new_resource.path}/#{e}" do
      owner new_resource.owner
      group new_resource.group
      action :create
      content v[:value].to_s
      mode v[:sensitive] ? '0600' : '0644'
    end
  end
end

action :delete do
  directory new_resource.path do
    action :delete
    recursive true
  end
end
