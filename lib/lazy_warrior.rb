require 'lazy_warrior/version'
require_relative 'lazy_warrior/client/base.rb'
require_relative 'lazy_warrior/client/pulls.rb'
require_relative 'lazy_warrior/client/repository.rb'
require_relative 'lazy_warrior/lazy_config.rb'

# Top level module
module LazyWarrior
  class Update
    def initialize
      @repository = Repository.new
      @pulls = Pulls.new
    end

    def tasks
      active_repos = @repository.fetch_repositories(LazyConfig.github[:repos])
      active_repos.each do |repo|
        updated_pulls = @pulls.get_incomplete_reviews(repo)
        update_tasks(updated_pulls)
      end
    end

    private

    def update_tasks(pulls)
      pulls.each do |pull|
        tasks = `task githubid:#{pull[:id]} list`
        if tasks.empty?
          `task add "#{pull[:title]}" project:iteration.review scheduled:#{pull[:created_at]} due:2days priority:H githubid:#{pull[:id]}`
        end
      end
    end
  end
end
