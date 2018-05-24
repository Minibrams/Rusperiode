ActiveAdmin.register Page do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form title: 'Page' do |f|
    inputs 'Siden' do
      f.input :educational_domain_id, as: :select, collection: EducationalDomain.all, include_blank: false 
      f.input :slug
      f.input :title
      f.input :view_file
    end
    inputs 'Indhold' do
      f.input :content, as: :text 
      f.input :accordion, as: :text
    end
    actions
  end

end
