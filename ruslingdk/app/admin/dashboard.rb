ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Users' do
          ul do
            User.last(5).map do |user|
              li user.name
            end
          end
        end
      end

      column do
        panel 'Info' do
          para 'Welcome to Rusling.dk.'
        end
      end
    end
  end
end
