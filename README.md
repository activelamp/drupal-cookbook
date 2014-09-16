[![Build Status](https://travis-ci.org/activelamp/drupal-cookbook.png)](https://travis-ci.org/activelamp/drupal-cookbook)

Description
===========

This cookbook provides an easy way to deploy a Drupal website, as well as a recipe for installing Drush.

Requirements
============

* `php`
* `composer`

This cookbook is not responsible for satisfying these requirements. You will have to provision your machine with these through your platform's dependency manager (`apt`, `yum`, etc), or through other cookbooks.

## Platforms:

* Tested on Ubuntu/Debian only, but the deploy actions should work with any platform.

Recipes
=====================

### `drupal_make::drush`

Installs `Drush` on your node:

```ruby
include_recipe 'drupal_make::drush'
```

Attributes
==========

Option | Default | Description
-------|---------|------------
__[:drupal_make][:drush][:version]__ | `"7.x"` | The version of `Drush` to install.
__[:drupal_make][:drush][:user]__ | `"root"` | The user responsible for the commands. The `drush` command will be registered under this user.
__[:drupal_make][:drush][:group]__ | `"root"` | The group responsible for the commands.
__[:drupal_make][:drush][:install_path]__ | `"/usr/local/bin/drush"` | Where the `drush` executable will be linked to.
__[:drupal_make][:drush][:composer_command]__ | `"composer"` | The `Composer` command that will work in your node. The default value will assume that `composer` is available globally. However you can specify something like `"php /path/to/composer.phar"` if the executable is somewhere that cannot be resolved by the `$PATH` environment variable.


Resources / Providers
=====================

### `drush_make`

This resource uses the `drush make` command to build a Drupal site from a make file found in your project repository. 

These are the things that happen during the make process:

* `drush make` is called
* Custom modules will be symlinked to the Drupal modules directory.
* Custom themes will be symlinked to the Drupal themes directory.

#### Actions
  * All actions of the [`deploy`](https://docs.getchef.com/resource_deploy.html) resource is valid and works the same way, as the `drush_make` resource simply extends `Chef::Resource::Deploy`
  
#### Examples

###### Deploy a Drupal site

```ruby
drupal_make "/path/to/project" do
    repo 'git@github.com:your_organization/your_drupal_project.git
    git_ssh_wrapper '/tmp/ssh-wrapper.sh'
    revision 'v2.0'
    user node[:drupal_make][:drush][:user]
    group node[:drupal_make][:drush][:group]
    action :deploy
end
```

#### Options 

All options for the [`deploy`](https://docs.getchef.com/resource_deploy.html) resource is applicable. The following options are `drush_make`-specific:

Option | Default | Description
-------|---------|------------
__make_file__ | `"drupal.make"` | The path to the make file relative to your project repository root.
__build_to__ | `"_build"` | Where the Drupal site to be built, relative to your project repository root.
__themes_dir__ | `"themes"` | Where your custom themes are relative to your project repository root. Specify `nil` if none.
__modules_dir__ | `"modules"` | Where your custom themes are relative to your project repository root. Specify `nil` if none.

License and Authors
===================

Author: Bez Hermoso <bez@activelamp.com>

Author: ActiveLAMP

Copyright: 2012-2014, ActiveLAMP

[Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0.html)
