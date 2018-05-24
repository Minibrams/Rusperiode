ActiveAdmin.register Event do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :description, :location, :lat, :lng, :educational_domain_id, :begin_at, :planner
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

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
      f.input :begin_at
    end
    inputs 'Hvem' do
      f.input :planner, as: :select, collection: ["ruskorps", "ida", "prosa", "studentersamfundet"], include_blank: false
    end
    actions
  end
end
