require 'octokit'
require 'json'
require_relative 'base'

class Pulls < Base
  def initialize
    super()
  end

  def get_incomplete_reviews(repo)
    open_pulls(repo)
  end

  private

  def open_pulls(repo)
    pulls = repo.rels[:pulls].get.data
    result = []

    pulls.collect do |pull|
      if pull[:state].eql? 'open'
        result << populate_result(pull, {})
      end
    end

    result.select { |x| !x.empty? }
  end

  def finished_review?(pull)
    comments = pull.rels[:comments].get.data

    comments.select! do |c|
      (c[:user][:login].eql? Octokit.user.login) && (c[:body].eql? '+1')
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
    result[:finished] = finished_review?(pull)

    result
  end
end
