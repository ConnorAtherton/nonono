module Helpers
  def run(path, cmd)
    mock_history(cmd)
    system("cd #{path} && #{cmd}")
  end

  def run_nonono(path, undo)
    cmd = "nonono #{undo && 'undo'}"
    run(path, cmd)
  end

  def create_repo(action)
    path = "#{test_repos_path}/#{action}_repo"
    FileUtils.mkdir_p path
    initialize_repo path
    path
  end

  def initialize_repo(path)
    run(path, 'git init')
  end

  def git_repo?(path)
    File.directory?(path + '/.git')
  end
end
