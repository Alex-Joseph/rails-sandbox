class CreateTableTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.index :id
    end
  end
end
