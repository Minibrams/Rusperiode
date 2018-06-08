ActiveAdmin.register Page do
  includes :educational_domain
  permit_params do
    params = %i[slug title view_file content accordion]
    params += [:educational_domain_id] if current_user.system_admin?
    params
  end

  index do
    selectable_column
    column :slug
    column :title
    column 'content' do |p|
      truncate(p.content, omision: '...', length: 100)
    end

    column :educational_domain if current_user.system_admin?
    actions
  end

  form title: 'Page' do |f|
    inputs 'Siden' do
      if current_user.system_admin?
        f.input :educational_domain, as: :select, collection: EducationalDomain.all, include_blank: false
      end
      f.input :slug
      f.input :title
      f.input :view_file
    end
    inputs 'Indhold' do
      f.input :content, as: :quill_editor
      f.input :accordion, as: :jsonb
    end
    actions
  end

  scope_to(if: -> { current_user.domain_admin? }) do
    current_user.educational_domain
  end
end
