tag species.name do
  a 'picture', species.name

  partial 'species', collection: :children, as: :species
end
