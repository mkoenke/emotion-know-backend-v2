class CreateVideoReports < ActiveRecord::Migration[6.0]
  def change
    create_table :video_reports do |t|
      t.string :title
      t.integer :video_entry_id
      t.integer :child_id
      t.integer :parent_id
      t.decimal :anger, array: true, default: []
      t.decimal :disgust, array: true, default: []
      t.decimal :fear, array: true, default: []
      t.decimal :joy, array: true, default: []
      t.decimal :sadness, array: true, default: []
      t.decimal :surprise, array: true, default: []

      t.timestamps
    end
  end
end
