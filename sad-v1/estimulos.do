force -repeat 10ns /clk 0 0ns, 1 5ns
force /sample_can 00000000 0ns -r 2000ns
force /sample_ori 00000001 0ns -r 2000ns
force /enable 0 0ns, 1 10ns, 0 60ns -r 2000ns 
force /reset 0 0ns -r 2000ns