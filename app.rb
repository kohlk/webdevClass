require 'rubygems'

file_contents = File.read('todo.txt')

lines = file_contents.split("\n")

lines.each do |line|
    thing, date = line.split("-")
    puts "ToDo -  #{date}: #{thing}"
end

