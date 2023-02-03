require "active_support/core_ext/time/conversions"
require "mrsk/commands/base"

class Mrsk::Commands::Auditor < Mrsk::Commands::Base
  def record(line)
    append \
      [ :echo, "'#{tags} #{line}'" ],
      audit_log_file
  end

  def reveal
    [ :tail, "-n", 50, audit_log_file ]
  end

  private
    def audit_log_file
      "mrsk-#{config.service}-audit.log"
    end

    def tags
      "[#{timestamp}] [#{performer}]"
    end

    def performer
      `whoami`.strip
    end

    def timestamp
      Time.now.to_fs(:db)
    end
end