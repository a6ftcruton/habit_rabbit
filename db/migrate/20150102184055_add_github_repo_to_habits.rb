class AddGithubRepoToHabits < ActiveRecord::Migration
  def change
    add_column :habits, :github_repo, :boolean, default: false
  end
end
