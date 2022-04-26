# COMPANIES
# 5.times do
#   Company.create({
#                    name: Faker::Company.name,
#                    description: Faker::Company.industry,
#                    address: Faker::Address.full_address,
#                    phone: Faker::PhoneNumber.cell_phone_with_country_code
#                  })
# end
#

# CANDIDATES
# 5.times do
#   gen_name = Faker::Name.first_name
#   Candidate.create({
#                    name: gen_name,
#                    lastname: Faker::Name.last_name,
#                    email: Faker::Internet.free_email(name: gen_name),
#                    phone: Faker::PhoneNumber.cell_phone_with_country_code
#                  })
# end