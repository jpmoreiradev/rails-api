namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    puts "Apagando contatos antigos..."
    Contact.delete_all

    puts "Cadastrando novos contatos..."
    100.times do
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 55.years.ago, to: 18.years.ago)
      )
    end

    puts "✅ Contatos cadastrados com sucesso!"
  end
end
