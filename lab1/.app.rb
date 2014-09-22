require 'rubygems'
require 'sanitize'

file_contents = File.read('todo.txt')
file_contents = Sanitize.clean(file_contents) 

lines = file_contents.split("\n")

lines.each do |line|
    thing, date = line.split("-")
    puts "ToDo -  #{date}: #{thing}"
end

