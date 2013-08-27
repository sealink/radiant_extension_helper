require "radiant_extension_helper/version"

module RadiantExtensionHelper
  def self.copy_assets(extension_name)
    AssetManager.new(extension_name).copy_assets
  end


  class AssetManager
    def initialize(extension_name)
      @extension_name = extension_name
    end


    def copy_assets
      puts "Copying assets from #{extension}"
      copy_files 'public/**/*'
      copy_files 'config/*.yml.example'
    end


    def copy_files(files)
      Dir["#{root}/#{files}"].reject{|path| File.directory?(path)}.each do |file|
        copy_file(file)
      end
    end


    def copy_file(file)
      path = file.gsub(/^#{root}/, '')
      directory = File.dirname(path)
      FileUtils.mkdir_p File.join(Rails.root, directory), :verbose => false
      FileUtils.cp file, File.join(Rails.root, path), :verbose => false
    end


    def root
      extension.root
    end


    def extension
      @extension ||= "#{@extension_name}_extension".camelize.constantize
    end
  end


  module ConfigHelpers
    def in_rake? 
      Rake.application.top_level_tasks.present?
    end


    def error(message, required_for_env = nil)
      # Never raise exception in rake tasks
      if !in_rake? && (required_for_env.nil? || Rails.env == required_for_env)
        raise message
      else
        puts message
      end
    end


    def config_exists?(required_for_env = nil)
      return true if File.exists?(config_file)

      use_example_message = "MISSING CONFIG: #{config_file} does not exist. Please use #{config_file}.example as a reference."
      run_task_message = "#{use_example_message} You can get the example file by running rake radiant:extensions:#{extension_key}:update"
      if File.exists?("#{config_file}.example")
        error use_example_message, required_for_env
      else
        error run_task_message, required_for_env
      end

      false
    end

  
    def extension_key
      base_name.underscore
    end


    def configurator
      @configurator ||= base_name.constantize
    end


    def base_name
      self.class.name.gsub(/Extension$/, '')
    end


    def config_file
      @config_file ||= "#{Rails.root}/config/#{config_file_name}.yml"
    end


    def config_file_name
      @config_file_name ||= extension_key
    end


    def configure
      yml_config = YAML::load(File.read(config_file))
      configurator.configure do |config|
        yml_config.each do |key, value|
          config.send("#{key}=", value)
        end

        yield config if block_given?
      end
    end
  end
end

Radiant::Extension.send :include, RadiantExtensionHelper::ConfigHelpers
