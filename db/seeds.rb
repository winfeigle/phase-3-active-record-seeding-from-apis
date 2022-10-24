# Add seed data in this file

puts "Seeding spells..."

# these are the spells we want to pull from the api and add to the database
spells = ["acid-arrow", "animal-messenger", "calm-emotions", "charm-person"]

# iterate over each spell
spells.each do |spell|
    # make a request to the endpoint for the individual spell:
    response = RestClient.get "https://www.dnd5eapi.co/api/spells/#{spell}"

    # the response will come back as a JSON-formatted string.
    # use JSON.parse to convert this string to a Ruby hash:
    spell_hash = JSON.parse(response)

    Spell.create(
        name: spell_hash["name"],
        level: spell_hash["level"],
        # spell_hash["desc"] returns an array, so we need to access the first index to get just a string of the description
        description: spell_hash["desc"][0]
    )
end

puts "Done seeding!"
