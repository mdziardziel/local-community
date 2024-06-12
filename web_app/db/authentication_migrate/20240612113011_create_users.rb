class CreateUsers < ActiveRecord::Migration[7.1]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

  def change
    create_table :users do |t|
      t.uuid :uuid, default: "gen_random_uuid()", null: false
      t.string :email
      t.string :password_digest
      t.references :community, index: true

      t.timestamps
    end
  end
end
