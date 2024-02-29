puts "****Bitwise Operations****"

set a 20
set b 5
set c 9

set var0 [expr $a & $c]
set var1 [expr $a & $b]
set var2 [expr $a & $a]

puts "The content of var0 is $var0"
puts "The content of var1 is $var1"
puts "The content of var2 is $var2"