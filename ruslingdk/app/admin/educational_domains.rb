ActiveAdmin.register EducationalDomain do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :primary_menu_id, :secondary_menu_id, :default_page_id, :name, :domain, :color_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form title: 'Side' do |f|
    inputs 'Siden' do
      f.input :default_page, as: :select, collection: Page.id.all, include_blank: false
      f.input :name
      f.input :domain
      f.input :colors
    end
    inputs 'Menuer' do
      f.input :primary_menu, as: :select, collection: Menu.all, include_blank: false
      f.input :secondary_menu, as: :select, collection: Menu.all, include_blank: false  
    end
    actions
  end
end
