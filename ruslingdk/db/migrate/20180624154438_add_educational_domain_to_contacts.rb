class AddEducationalDomainToContacts < ActiveRecord::Migration[5.1]
  def change
    add_reference :sponsors, :educational_domain, foreign_key: true
  end
end
