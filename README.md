# envdir_ii

![CircleCI](https://img.shields.io/circleci/build/github/limitusus/envdir_ii/master?token=4cd3700996f9934222b4899ee5d84dfe3a2f62a7)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/limitusus/envdir_ii)
![Chef cookbook](https://img.shields.io/cookbook/v/envdir_ii)

This cookbook provides a single resource `envdir_ii_envdir`, mainly
used for `envdir` command in `daemontools`
(http://cr.yp.to/daemontools.html).

## Resource: `envdir`

### Synopsis

Expresses a fully managed directory in form of a hash.

```ruby
envdir_ii_envdir '/service/my_service/env' do
  owner 'application_user'
  group 'application_group'
  values(
    'PATH' => { value: "/usr/local/bin:/usr/bin" },
    'DB_PASSWORD' => { value: "P@SSW0RD", sensitive: true },
  )
  # If you need service reload on change
  notifies :reload, 'service[my_service]', :delayed
end
```

Any files in the directory not defined in `values` will be removed.

### Properties

- `path`: directory path managed by this resource. if omitted, the resource name is used.
- `owner`: Directory and files owner
- `group`: Directory and files group
- `values`: Hash of `:value` and `:sensitive`; `:value` is the content of file, and `:sensitive` sets the file read-writable only by its `owner`/`group`
- `action`: either `:create` or `:delete`; `:delete` action deletes the whole directory
