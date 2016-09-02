Thing.destroy_all
200.times do
  Thing::Create.call(
    thing: {
      name: Faker::Company.name,
      description: Faker::Company.catch_phrase
    }
  )
end

Thing.all.each do |thing|
  rand(32..47).times do
    Comment::Create.call(
      thing_id: thing.id,
      comment: {
        body: Faker::Hipster.sentence,
        weight: rand(0..1).to_s,
        user: {
          email: Faker::Internet.free_email
        }
      }
    )
  end
end
