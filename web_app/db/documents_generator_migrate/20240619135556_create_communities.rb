class CreateCommunities < ActiveRecord::Migration[7.1]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

  def change
    create_table :communities do |t|
      t.uuid :uuid, default: "gen_random_uuid()", null: false

      t.timestamps
    end
  end
end
