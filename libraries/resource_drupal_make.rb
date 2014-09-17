require 'chef/resource'

class Chef
  class Resource
    class DrupalMake < Chef::Resource::Deploy

      def initialize(name, run_context=nil)
        super
        @resource_name = :drupal_make
        @make_file = 'drupal.make'
        @themes_dir = 'themes'
        @modules_dir = 'modules'
        @drush = '/usr/local/bin/drush'
        @provider = Chef::Provider::DrupalMake::Timestamped
        @build_to = '_build'
        @symlink_before_migrate.clear
        @create_dirs_before_symlink.clear
        @symlinks.clear
        @purge_before_symlink.clear
      end

      def make_file(arg=nil)
        set_or_return(:make_file, arg, :kind_of => String)
      end

      def themes_dir(arg=nil)
        set_or_return(:themes_dir, arg, :kind_of => String)
      end

      def modules_dir(arg=nil)
        set_or_return(:modules_dir, arg, :kind_of => String)
      end

      def drush(arg=nil)
        set_or_return(:drush, arg, :kind_of => String)
      end

      def before_make(arg=nil, &block)
        arg ||= block
        set_or_return(:before_migrate, arg, :kind_of => [Proc, String])
      end

      def after_make(arg=nil, &block)
        arg ||= block
        set_or_return(:after_make, arg, :kind_of => [Proc, String])
      end

      def build_to(arg=nil)
        set_or_return(:build_to, arg, :kind_of => String)
      end
    end
  end
end