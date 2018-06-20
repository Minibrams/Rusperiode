RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
<<<<<<< HEAD
=======

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.start
  end

  config.after(:each) do |example|
    DatabaseCleaner.clean
  end

>>>>>>> 393b10fcb2d34301b23e3290ebac0f9c3b062a7e
end
