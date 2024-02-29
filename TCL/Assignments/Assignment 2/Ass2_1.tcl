puts "****Writing Verilog Block Interface****"

set modname Up_Dn_Counter

set in_ports [list IN Load Up Down CLK]
					
set in_ports_width [list 4 1 1 1 1]
						
set out_ports [list High Counter Low]
					
set out_ports_width [list 1 4 1]
							
puts "module $modname ("
set i 0
foreach x $in_ports {

set j [lindex $in_ports_width $i]

if {$j == 1} {
puts " input \t\t$x,"

} else {
puts " input \t\[[expr $j-1]:0\] \t$x,"

}
incr i

}

set i 0

set length  [llength $out_ports]

foreach M $out_ports {

set j [lindex $out_ports_width $i ]

if {$i == [expr $length - 1]} {

if {$j == 1} {

puts " output \t\t$M"
puts ");"
} else {
puts " output \t\[[expr $j-1]:0] \t$M"
puts ");"
}
} else {
if {$j == 1} {
puts " output \t\t$M,"
} else {
puts " output \t\[[expr $j-1]:0] \t$M,"
}
}



incr i
}