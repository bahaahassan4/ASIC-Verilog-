set fh [open rtl.txt r]
set designs [read $fh]
close $fh
set mylist ""
foreach x $designs {
lappend mylist $x

}

puts "{$mylist}"