class CreateDocuments < ActiveRecord::Migration[7.1]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

  def change
    create_table :documents do |t|
      t.uuid :uuid, default: "gen_random_uuid()", null: false, index: true
      t.string :template_name
      t.string :content
      t.references :community, index: true

      t.timestamps
    end
  end
end
