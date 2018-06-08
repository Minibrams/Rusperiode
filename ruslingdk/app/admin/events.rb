ActiveAdmin.register Event do
  includes :educational_domain

  permit_params do
    permitted = %i[title description location lat lng begin_at planner]
    permitted << :educational_domain_id if current_user.system_admin?
    permitted
  end

  index do
    selectable_column
    column :title
    column 'Description' do |p|
      truncate(p.description, omision: '...', length: 100)
    end
    column 'Coordinates' do |p|
      "#{p.lat}, #{p.lng}"
    end
    column 'Begins at' do |p|
      I18n.l(p.begin_at, format: :short)
    end

    column :educational_domain if current_user.system_admin?
    actions
  end

  form title: 'Event' do |f|
    inputs 'Hvad' do
      f.input :title
      f.input :description, as: :text
    end
    inputs 'Hvor' do
      f.input :location
      f.input :lat
      f.input :lng
    end
    inputs 'Hvornår' do
      f.input :begin_at, as: :datetime_select
    end
    inputs 'Hvem' do
      f.input :planner, as: :select, collection: %w[ruskorps ida prosa studentersamfundet], include_blank: false
    end
    actions
  end

  scope_to(if: -> { current_user.domain_admin? }) do
    current_user.educational_domain
  end
end
