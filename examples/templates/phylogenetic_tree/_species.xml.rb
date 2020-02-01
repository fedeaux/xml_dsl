tag species[:name] do
  a 'picture', species[:picture]

  partial 'species', collection: species[:children], as: :species
end
