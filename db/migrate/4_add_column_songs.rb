class AddColumnSongs < ActiveRecord::Migration
  
  def change
    add_column :songs, :upvote, :integer
  end

end


