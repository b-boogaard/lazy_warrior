require 'octokit'
require 'json'

class Repositry
  def initialize(config, client)
    @config = config
    @client = client
  end

  def repos
    @repos ||= populate_repo
  end

  private

  def populate_repo
    config.github[:repos].each do |r|
      @repos << client.repository(r)
    end
  end
end
