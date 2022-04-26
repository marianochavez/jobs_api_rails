5.times do
  Company.create({
                   name: Faker::Company.name,
                   description: Faker::Company.industry,
                   address: Faker::Address.full_address,
                   phone: Faker::PhoneNumber.cell_phone_with_country_code
                 })
end