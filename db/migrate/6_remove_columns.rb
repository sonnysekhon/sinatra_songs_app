class RemoveColumns < ActiveRecord::Migration
  
  def change
    remove_column :songs, :upvote
    remove_column :users, :upvotes
  end

end


