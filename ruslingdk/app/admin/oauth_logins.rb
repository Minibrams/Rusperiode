ActiveAdmin.register OauthLogin do
  menu if: -> { current_user.system_admin? }
  actions :index, :show
  includes :user

  index do
    selectable_column
    column :id
    column :provider
    column :uid
    column :token
    column :secret
    column :expires_at
    column :user

    actions
  end
end
