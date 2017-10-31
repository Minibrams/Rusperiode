Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, '3b8bd958f1b650d750dd', 'fbe35f02927408d584411fea3247e2f1c867d705', scope: 'user,user:email'
  provider :facebook, '172404533469049', 'c02473825957175dfaeb9fe153ad24e8'
end
