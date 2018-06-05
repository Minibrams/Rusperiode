ActiveAdmin.register EducationalDomain do
  permit_params :primary_menu_id, :default_page_id, :name, :domain, :color_id
  includes :primary_menu, :default_page

  form title: 'Side' do |f|
    inputs 'Siden' do
      f.input :default_page, as: :select, collection: Page.id.all, include_blank: false
      f.input :name
      f.input :domain
      f.input :colors
    end
    inputs 'Menuer' do
      f.input :primary_menu, as: :select, collection: Menu.all, include_blank: false
    end
    actions
  end

  index do
    selectable_column
    column :name
    column :domain if current_user.system_admin?
    column :default_page
    column :primary_menu
    column "Colors" do |ed|
      raw(ed.colors.map { |(k,v)| "#{k}: #{v}" }.join(raw('<br />')))
    end

    actions
  end

  controller do
    def scoped_collection
      if current_user.system_admin?
        end_of_association_chain
      else
        end_of_association_chain.where(id: [current_user.educational_domain_id])
      end
    end
  end
end
