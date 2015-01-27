class CreateWorktimelogs < ActiveRecord::Migration
  def change
    create_table :worktimelogs do |t|
      t.integer :issue_id
      t.integer :user_id
      t.timestamp :started
      t.timestamp :finished
      t.integer :total
      t.integer :flag
    end
  end
end
