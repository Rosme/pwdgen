# coding: utf-8

count = 16

if ARGV.length == 1
    count = ARGV[0].to_i
end

special = ['/', '\\', '&', '%', '$', '!', '(', ')', '@', '#', '?']
chars = ('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a

special.each do|s|
    chars << s
end

i = 0

password = ""
begin
    password << chars.sample()
    i += 1
end while i < count

puts password
