require 'octokit'

class Base
  def initialize
    provide_credentials
  end

  private

  def jira
    LazyConfig.jira
  end

  def github
    LazyConfig.github
  end

  def provide_credentials
    Octokit.configure do |c|
      c.login = LazyConfig.github[:username]
      c.password = LazyConfig.github[:password]
    end
  end
end
