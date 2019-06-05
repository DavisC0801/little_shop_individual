class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.float :value
      t.integer :type
      t.references :user, foreign_key: true
    end
  end
end
