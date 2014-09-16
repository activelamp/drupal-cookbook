require 'chef/provider'

class Chef
  class Provider
    class DrupalMake < Chef::Provider::Deploy
      def migrate
        super
        callback(:before_make, @new_resource.before_make)
        make
        callback(:after_make, @new_resource.after_make)
      end
      def make
        converge_by("Making Drupal site #{ release_path }") do
          Chef::Log.info "Making Drupal site on #{ release_path }/#{ @new_resource.build_to }"
          command = "#{ @new_resource.drush } make --working-copy --no-gitinfofile #{ @new_resource.make_file } #{ @new_resource.build_to }"
          executor = Chef::Resource::Execute.new('drush-make', @run_context)
          executor.cwd(release_path)
          executor.provider(Chef::Provider::Execute)
          executor.command(command)
          executor.user(@new_resource.user)
          executor.group(@new_resource.group)
          executor.run_action(:run)
          {'modules/custom' => @new_resource.modules_dir, 'themes/custom' => @new_resource.themes_dir}.each do |from, to|
            link = Chef::Resource::Link.new("#{ release_path }/#{ @new_resource.build_to }/#{ from }", @run_context)
            link.to("#{ release_path }/#{ to }")
            link.owner(@new_resource.user)
            link.run_action(:create)
          end
        end
      end
    end
  end
end