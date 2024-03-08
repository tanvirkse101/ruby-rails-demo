# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each do |user|
    micropost = user.microposts.create!(content: content)
    # Create comments for each micropost
    3.times do
      contents = Faker::Lorem.sentence(word_count: 3)
      micropost.comments.create!(user: users.sample, content: contents)
    end
  end
end

# Each user creates a group
users.each do |user|
  group_name = Faker::Lorem.word.capitalize
  group = user.created_groups.create!(name: group_name, description: Faker::Lorem.sentence(word_count: 20))

  # Add members to the group (excluding the creator)
  members = users.sample(5) - [user]
  members.each do |member|
    chat_text = Faker::Lorem.sentence(word_count: 20)
    group.members << member
    Chat.create!(user: member, group: group, text: chat_text)
  end
end


# ユーザーフォローのリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
