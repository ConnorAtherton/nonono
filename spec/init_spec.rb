require 'spec_helper'

describe 'git init' do
  before :all do
    @repo_path = create_repo :init
  end

  it 'creates a git repo' do
    expect(git_repo?(@repo_path)).to eq(true)
  end

  it 'will be deleted by nonono' do
    run_nonono(@repo_path, true)
    expect(git_repo?(@repo_path)).to eq(false)
  end
end
