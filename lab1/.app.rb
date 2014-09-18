require 'rubygems'
require 'sanitize'

file_contents = File.read('todo.html')
file_contents = Sanitize.clean(file_contents) 

lines = file_contents.split("\n")

puts "thing: #{lines.shift}"

lines.each do |line|
    thing, date = line.split("-")
    puts "ToDo -  #{date}: #{thing}"
end

