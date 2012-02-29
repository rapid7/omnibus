module Omnibus

  # Fetcher implementation for projects on the filesystem
  class PathFetcher < Fetcher

    name :path

    def initialize(software)
      @name = software.name
      @source = software.source
      @project_dir = software.project_dir
      @version = software.version
    end

    def description
      s=<<-E
source path:    #{@source[:path]}
local location: #{@project_dir}
E
    end

    def fetch
      sync_cmd = "rsync --delete -a #{@source[:path]}/ #{@project_dir}/"
      shell = Mixlib::ShellOut.new(sync_cmd)
      shell.run_command
      shell.error!
    end
  end
end