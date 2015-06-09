require 'octokit'
require_relative 'base'

class Repository < Base
  def initialize
    super()
  end

  def fetch_repositories(repos=get_config_repos)
    repos.map { |r| fetch_repository(r) }
  end

  def fetch_repository(repo)
    Octokit.repo repo
  end

  private

  def get_config_repos
    LazyConfig.github[:repos]
  end
end
