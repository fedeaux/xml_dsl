# frozen_string_literal: true

final = ''

Dir['*.rb'].each do |file|
  next if ['as_one_file.rb', 'version.rb'].include? file

  final += File.read(file).split("\n")[1..-2].join("\n") + "\n\n"
end

puts "module XmlDsl\n#{final}\nend"
