ActiveAdmin.register Menu do
  includes :educational_domain
  json_editor

  permit_params do
    permitted = [:name, :items]
    permitted << :educational_domain_id if current_user.system_admin?
    permitted
  end

  form do |f|
    inputs 'Menu' do
      f.input :name
      f.input :items, as: :jsonb
    end

    actions
  end

  index do
    selectable_column
    column :name

    if current_user.system_admin?
      column :educational_domain
    end
    actions
  end

  scope_to(if: -> { current_user.domain_admin? }) do
    current_user.educational_domain
  end
end
