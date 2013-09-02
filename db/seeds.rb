# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create({username: "Alpha", password_hash: "foo"});
User.create({username: "Beta", password_hash: "foo"});
User.create({username: "Gamma", password_hash: "foo"});
Question.create({title: "Question One", body: "Body One"});
Question.create({title: "Question Two", body: "Body Two"});
Question.create({title: "Question Three", body: "Body Three"});
Answer.create({user_id: 1, question_id:1, body: "Answer 1-1"});
Answer.create({user_id: 2, question_id:1, body: "Answer 1-2"});
Answer.create({user_id: 3, question_id:1, body: "Answer 1-3"});
Answer.create({user_id: 3, question_id:2, body: "Answer 2-1"});
Answer.create({user_id: 2, question_id:2, body: "Answer 2-2"});
Answer.create({user_id: 1, question_id:2, body: "Answer 2-3"});
Answer.create({user_id: 2, question_id:3, body: "Answer 3-1"});
Answer.create({user_id: 2, question_id:3, body: "Answer 3-2"});
Answer.create({user_id: 1, question_id:3, body: "Answer 3-3"});