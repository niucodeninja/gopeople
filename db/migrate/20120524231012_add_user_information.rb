class AddUserInformation < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string    :name
      t.string    :last_name
      t.date      :birth_date
    end
  end

  def down
    change_table :users do |t|
      t.remove :name, :last_name, :birth_date
    end
  end
end
