require 'octokit'
require 'json'
require_relative 'base'

class Pulls < Base
  def initialize
    super()
  end

  def get_incomplete_reviews
    open_pulls
  end

  private

  def open_pulls
    repos = Repository.new.get_repositories(github[:repos])
    pulls = pulls_by_repo(repos)

    pulls.collect do |pull|
      if pull[:state].contains? 'open'
        result = populate_result(pull, {})
      end

      result || {}
    end

    pulls.select { |x| !x.empty? }
  end

  def pulls_by_repo(repos)
    repos.map { |repo| repo.rels[:pulls].get.data }
  end

  def finished_review?(pull)
    comments = pull.rels[:comments].get.data

    comments.select do |c|
      c[:user][:login].eql? Octokit.user.login
      and c[:body].eql? '+1'
    end

    !comments.empty?
  end

  def populate_result(pull, result)
    result[:state] = 'open'
    result[:title] = pull[:title]
    result[:owner] = pull[:user][:login]
    result[:html] = pull.rels[:html].href
    result[:diff] = pull.rels[:diff].href
    result[:created_at] = pull[:created_at]
    result[:finished] = finished_review?(pull, client)

    result
  end
end
