#  USER SEEDS 
#-----------------------
User.create!(
    name: "Joe", 
    email_address: "joe@example.com", 
    uid: "12345", 
    provider: "twitter", 
    image: 'http://example.com/image/12342345', 
    oauth_token: "fjdkslfaPOI", 
    oauth_secret: "abc123"
)
puts "Planted User seeds"

#  HABIT SEEDS 
#-----------------------
Habit.create!(name: "first exercise", user_id: "1") 
Habit.create!(name: "second exercise", user_id: "1") 
Habit.create!(name: "I will read things", user_id: "1") 

puts "Planted Habit seeds"
