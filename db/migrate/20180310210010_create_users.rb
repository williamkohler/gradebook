class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string      :name
      t.string      :email
      t.datetime    :created_at
      t.datetime    :updated_at
      t.string      :password_digest
      t.string      :remember_digest
      t.boolean     :admin, default: false
      t.boolean     :student
      t.boolean     :teacher
      t.string      :activation_digest
      t.boolean     :activated, default: false
      t.datetime    :activated_at
      t.string      :reset_digest
      t.datetime    :reset_sent_at

      t.timestamps
    end
  end
end
