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
class Config
  private

  # @private
  def config
    fail ["Must specify configuration values in ~user/.lazy_warrior.\n",
          "Use `rake config` for more information.\n"
         ].join('') unless config_exists?

    @config ||= Psych.load_file('~user/.lazy_warrior')
  end

  # @private
  def config_exists?
    File.file?('~user/.lazy_warrior')
  end
end
