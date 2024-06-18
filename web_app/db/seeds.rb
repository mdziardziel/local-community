# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


case Rails.env
when "development"
  unless Authentication::User.first
    community = Authentication::Community.create!
    Authentication::User.create!(email: "test@test.test",
                                 password: "test123456789",
                                 password_confirmation: "test123456789",
                                 community:)
  end
end