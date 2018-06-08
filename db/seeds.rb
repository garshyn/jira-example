# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if JourneyMap.none?
  JourneyMap.new(
    title: 'Sample journey map',
  ).tap do |map|
    map.steps.build([
      {
        title: 'Step 1',
      },
      {
        title: 'Step 2',
      },
      {
        title: 'Step 3',
      },
    ])

    map.save!
  end
end
