restart -f

force clk 0 0ns,1 10ns -r 20ns
force rst 0 0ns,1 20ns,0 560ns,1 600ns
force in1 10#16777215 0ns,10#25 600ns
force in2 10#16777215 0ns,10#13 600ns


run 1500ns
