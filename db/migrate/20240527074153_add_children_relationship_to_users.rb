class AddChildrenRelationshipToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :parent, foreign_key: { to_table: :users }, index: true
  end
end
