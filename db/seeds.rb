require 'faker'

5.times do
  person = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }
  person[:email] = Faker::Internet.safe_email("#{person[:first_name]}.#{person[:last_name]}")
  person[:password_hash] = "xxx"
  person[:username] = "#{person[:first_name]}#{person[:last_name]}".downcase

  contact = User.new(person)
  contact.password = contact.password_hash
  contact.save!
end

20.times do
  list_details = { name: Faker::Name.title, tier: (1+rand(3)), user_id: (1+rand(5))}
  list = List.new(list_details)
  list.save!
end

80.times do
  person = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, title: Faker::Name.title, company: Faker::Company.name, list_id: (1+rand(20)) }
  connection = Connection.new(person)
  connection.save!
end

320.times do
  date = {date: Faker::Date.between(1.year.ago, Date.today)}
  date[:connection_id] = 1+rand(80)
  interaction = Interaction.new(date)
  interaction.save!
end
