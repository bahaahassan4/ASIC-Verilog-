puts "****Assignment 2.0****"

set cities {cairo alexandria damietta dakahlia faiyum sohag aswan}

set Cities_New {}

foreach x $cities {
set i [string index $x 0]
set j [string toupper $i]
set var0 [expr [string length $x]-1]
set var1 [string range $x 1 $var0]
set y [append j $var1]
lappend Cities_New $y
}

puts $Cities_New