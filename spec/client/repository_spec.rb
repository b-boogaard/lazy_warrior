require 'pry'
require_relative '../../lib/lazy_warrior/client/repository.rb'
require_relative '../../lib/lazy_warrior/lazy_config.rb'

RSpec.describe Repository do
  describe "#fetch_repository" do
    context "with a valid repository" do
      it "returns the data from github" do
        result = {worked: true}
        repository = Repository.new

        allow(Octokit).to receive(:repo).with('mock_repo').and_return(result)

        expect(repository.fetch_repository('mock_repo')).to eq(result)
      end
    end

    context "with an invalid repository" do
      it "returns an empty hash" do
        result = {}
        repository = Repository.new

        allow(Octokit).to receive(:repo).with('mock_repo').and_return(result)

        expect(repository.fetch_repository('mock_repo')).to eq(result)
      end
    end
  end

  describe "#fetch_repositories" do
    context "with a valid list of repositories" do
      it "returns data from github for each repository" do
        repos = ['mock_repo_one', 'mock_repo_two']
        result = [{worked: 'one'}, {worked: 'two'}]

        allow(Octokit).to receive(:repo).with(repos[0]).and_return(result[0])
        allow(Octokit).to receive(:repo).with(repos[1]).and_return(result[1])

        repository = Repository.new

        expect(repository.fetch_repositories(repos)).to eq(result)
      end
    end

    context "with a mix of valid and invalid repositories" do
      it "returns data from github for the valid repositories" do
        repos = ['mock_repo_one', 'mock_repo_bad']
        result = [{worked: 'one'}, {}]

        allow(Octokit).to receive(:repo).with(repos[0]).and_return(result[0])
        allow(Octokit).to receive(:repo).with(repos[1]).and_return({})

        repository = Repository.new

        expect(repository.fetch_repositories(repos)).to eq(result)
      end
    end
  end
end
