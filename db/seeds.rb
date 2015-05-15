User.create!(name:  "Nguyen Ngoc Truong",
             email: "truongadmin@gmail.com",
             password:              "12345678",
             password_confirmation: "12345678",
             role: "admin")

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,)
end

2.times do
  name = Faker::Name.name
  Category.create!(name: name)
end

categories = Category.order(:created_at).take(2)
50.times do
  content = Faker::Lorem.word
  categories.each{|category| category.questions.create!(content: content)}
end

questions = Question.order(:created_at).take(100)
3.times do
  content = Faker::Lorem.word
  questions.each{|question| question.answers.create!(content: content, correct: false)}
end

questions.each do |question|
  content = Faker::Lorem.word
  question.answers.create!(content: content, correct: true)
end

