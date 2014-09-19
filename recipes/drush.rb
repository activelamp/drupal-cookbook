#
# Cookbook Name:: activelamp_drupal
# Recipe:: drush
#
# Copyright (c) 2014 ActiveLAMP, All Rights Reserved.

composer_home = ::File.expand_path("~#{ node[:activelamp_composer][:drush][:user] }/.composer")
composer_drush_path = "#{ composer_home }/vendor/bin/drush"

drush_version = node[:activelamp_composer][:drush][:version] == '7.x' ? 'dev-master' : node[:activelamp_composer][:drush][:version]

execute 'drupal-make-drush-install' do
  creates composer_drush_path
  command  "#{ node[:activelamp_composer][:drush][:composer_command] } global require drush/drush:#{ drush_version }"
  user node[:activelamp_composer][:drush][:user]
  group node[:activelamp_composer][:drush][:group]
  environment({
    'COMPOSER_HOME' => composer_home
  })
end

link node[:activelamp_composer][:drush][:install_path] do
  to composer_drush_path
  owner node[:activelamp_composer][:drush][:user]
  mode '0777'
end