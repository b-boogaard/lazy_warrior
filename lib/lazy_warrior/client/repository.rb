require 'octokit'
require_relative 'base'

class Repository < Base
  def initialize
    super()
  end

  def fetch_repositories(repos)
    repos.map { |r| fetch_repository(r) }
  end

  def fetch_repository(repo)
    Octokit.repo repo
  end
end
