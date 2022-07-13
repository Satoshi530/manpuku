class AddSubjectToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :subject, :string
  end
end
