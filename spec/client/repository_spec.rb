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
end
