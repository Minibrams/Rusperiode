class CreateOauthLogin < ActiveRecord::Migration[5.1]
  def change
    create_table :oauth_logins do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.datetime :expires_at
      t.jsonb :raw_data
      t.belongs_to :user
    end
    add_index :oauth_logins, :provider
    add_index :oauth_logins, :uid
    add_index :oauth_logins, :token
    add_index :oauth_logins, :expires_at
  end
end
