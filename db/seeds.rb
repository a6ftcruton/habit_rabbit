#  USER SEEDS 
#-----------------------
#User.create!(
#    name: "Joe", 
#    email_address: "joe@example.com", 
#    uid: "12345", 
#    provider: "twitter", 
#    image: 'http://example.com/image/12342345', 
#    oauth_token: "fjdkslfaPOI", 
#    oauth_secret: "abc123"
#)
#
#puts "Planted User seeds"


#  HABIT SEEDS 
#-----------------------
Habit.create!(name: "first exercise", user_id: "1", start_date: "2014-12-1 22:40:48") 
Habit.create!(name: "second exercise", user_id: "1", start_date: "2014-11-1 22:40:48") 
Habit.create!(name: "I will read things", user_id: "1", start_date: "2014-10-1 22:40:48") 

#Habit.create!(name: "Do Some Push Ups", user_id: "2", start_date: "2014-12-1 22:40:48")  # Habit 4 matches auth user: testing

puts "Planted Habit seeds"


#  EVENT SEEDS 
#-----------------------
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-1 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-2 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-3 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-4 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-5 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-6 22:40:48" )
Event.create!(completed: false, habit_id: 1, created_at: "2014-12-7 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-8 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-9 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-10 22:40:48" )
Event.create!(completed: false, habit_id: 1, created_at: "2014-12-11 22:40:48" )
Event.create!(completed: false, habit_id: 1, created_at: "2014-12-12 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-13 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-14 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-15 22:40:48" )
Event.create!(completed: false, habit_id: 1, created_at: "2014-12-16 22:40:48" )
Event.create!(completed: false, habit_id: 1, created_at: "2014-12-17 22:40:48" )
Event.create!(completed: false, habit_id: 1, created_at: "2014-12-18 22:40:48" )
Event.create!(completed: true, habit_id: 1, created_at: "2014-12-19 22:40:48" )

#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-1 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-2 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-3 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-4 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-5 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-6 22:40:48" )
#Event.create!(completed: false, habit_id: 4, created_at: "2014-12-7 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-8 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-9 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-10 22:40:48" )
#Event.create!(completed: false, habit_id: 4, created_at: "2014-12-11 22:40:48" )
#Event.create!(completed: false, habit_id: 4, created_at: "2014-12-12 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-13 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-14 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-15 22:40:48" )
#Event.create!(completed: false, habit_id: 4, created_at: "2014-12-16 22:40:48" )
#Event.create!(completed: false, habit_id: 4, created_at: "2014-12-17 22:40:48" )
#Event.create!(completed: false, habit_id: 4, created_at: "2014-12-18 22:40:48" )
#Event.create!(completed: true, habit_id: 4, created_at: "2014-12-19 22:40:48" )


puts "Planted Event seeds"
