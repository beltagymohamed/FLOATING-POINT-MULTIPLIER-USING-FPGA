restart -f

add wave -position insertpoint  \
sim:/datapath/a \
sim:/datapath/b \
sim:/datapath/clk \
sim:/datapath/en \
sim:/datapath/rst \
sim:/datapath/c \
sim:/datapath/expb \
sim:/datapath/expf \
sim:/datapath/expa
force -freeze sim:/datapath/a 01000100111110100000000000000000 0
force -freeze sim:/datapath/b 01000100111110100000000000000000 0
force -freeze sim:/datapath/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/datapath/en 1 0
force -freeze sim:/datapath/rst 0 0,1 {100ps}
run 500ns
