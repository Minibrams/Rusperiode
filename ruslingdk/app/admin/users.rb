ActiveAdmin.register User do
  actions :index, :show, :edit, :update
  includes :educational_domain

  permit_params do
    permitted  = [:firstname, :lastname, :email] if current_user.system_admin? || current_user.id == object.id
    permitted += [:educational_domain_id, :domain_admin, :system_admin] if current_user.system_admin?
    permitted
  end

  index do
    selectable_column
    column :email
    column :firstname
    column :lastname

    if current_user.system_admin?
      column :educational_domain
      column :domain_admin
      column :system_admin
    end
    actions
  end

  form title: 'User' do |f|
    inputs 'User' do
      f.input :firstname
      f.input :lastname
      f.input :email
    end

    inputs 'Admin' do
      if current_user.system_admin?
        f.input :educational_domain, as: :select, collection: EducationalDomain.all, include_blank: false
        f.input :domain_admin
        f.input :system_admin
      end
    end
    actions
  end
end
