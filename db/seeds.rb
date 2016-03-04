# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.delete_all

john = User.create!(username: "JohnRocks1985", password: "johnrocks")
jan = User.create!(username: "JanRocks1985", password: "johnsucks")
larry = User.create!(username: "DarkFire1999", password: "darkfire")

Sub.delete_all

rails = Sub.create!(title: "/r/rails", description: "We love rails!", moderator_id: john.id)
golfing = Sub.create!(title: "/r/golfing", description: "John sucks", moderator_id: jan.id)
gaming = Sub.create!(title: "/r/gaming", description: "This is my level, I hope I do well.", moderator_id: larry.id)

Post.delete_all

p1 = john.posts.create!(title: "first", content: "first!")
p2 = john.posts.create!(title: "second", content: ":(")
p3 = jan.posts.create!(title: "john sucks", content: "john sucks")
p4 = jan.posts.create!(title: "golf", content: "but golf is awesome!")
p5 = larry.posts.create!(title: "my pain", content: "I am darkfire!")
p6 = larry.posts.create!(title: "whoops", content: "This is supposed to be about gaming")

PostSub.delete_all

rails.post_subs.create!(post_id: p1.id)
rails.post_subs.create!(post_id: p3.id)
rails.post_subs.create!(post_id: p5.id)
golfing.post_subs.create!(post_id: p3.id)
golfing.post_subs.create!(post_id: p4.id)
gaming.post_subs.create!(post_id: p5.id)
gaming.post_subs.create!(post_id: p6.id)
gaming.post_subs.create!(post_id: p2.id)

Comment.delete_all

c1 = p1.comments.create!(content: "This post sucks", author_id: jan.id)
c2 = p1.comments.create!(content: "You suck!", author_id: john.id, parent_comment_id: c1.id)
