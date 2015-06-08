require 'psych'

# Utility class to load configuration in YAML format
# from $HOME/.lazy_warrior. The following is the valid
# structure and the currently supported fields.
# github:
#   url: value
#   username: value
#   password: value
#   repos:
#     - repo1
#     - repo2
# jira:
#   url: value
#   username: value
#   password: value
#
# @todo Allow for password to be stored in a more secure location.
#     Allow for customizable jira queries and ability to look for different
#     states of github.
class LazyConfig
  def self.github
    config[:github]
  end

  def self.jira
    config[:jira]
  end

  def self.usage
    puts ['Reads a YAML structured from $HOME/.lazy_warrior.',
          'The following is the valid structure and the currently',
          'supported fields.',
          'github:', "\turl: value", "\tusername: value",
          "\tpassword: value", "\trepos:", "\t\t- repo1", "\t\t- repo2",
          'jira:', "\turl: value", "\tusername: value", "\tpassword: value"
         ].join("\n")
  end

  private

  # @private
  def self.config
    unless config_exists?
      puts ["Must specify configuration values in ~user/.lazy_warrior.\n",
            "Use 'rake config' for more information.\n"
           ].join('')
      exit(1)
    end

    @config ||= Psych.load_file("#{ENV['HOME']}/.lazy_warrior")
  end

  # @private
  def self.config_exists?
    File.file?("#{ENV['HOME']}/.lazy_warrior")
  end
end
