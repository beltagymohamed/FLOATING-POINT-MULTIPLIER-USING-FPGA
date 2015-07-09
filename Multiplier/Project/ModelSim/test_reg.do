restart -f

force clk 0 0ns,1 10ns -r 20ns
force rst 0 0ns,1 20ns
force a 10#20 0ns,10#15 60ns -r 120ns
force en 1 0ns,0 40ns,1 80ns

run 500ns
