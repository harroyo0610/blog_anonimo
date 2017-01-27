class PostTags < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      
      t.timestamps
    end

    create_table :tags do |t|
      t.string :label
      
      t.timestamps
    end

    create_table :post_tags do |t|
      t.belongs_to :post, index: true
      t.belongs_to :tag, index: true
      
      t.timestamps
    end
  end
end
