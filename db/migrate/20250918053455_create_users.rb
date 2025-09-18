class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      
      # Add default: false
      t.boolean :verified, default: false, null: false 
      
      t.string :verification_token

      t.timestamps
    end
    
    # Add UNIQUE indexes
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :verification_token, unique: true # Also good to index this
  end
end