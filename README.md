# Dual-Clock-Asynchronous-FIFO
Verilog Code of the FIFO based on the work of Clifford Cummings and its simulation specification.

#  FIFO TOP LEVEL 
![alt text](https://github.com/siddhant23tomar/Dual-Clock-Asynchronous-FIFO/blob/main/FIFO_TOP_LEVEL.png?raw=true)


# Short Description of Verilog Files 

## fifo1.v 

The top-level FIFO module is a parameterized FIFO design with all sub-blocks instantiated using the recommended
practice of doing named port connections. The top-level module instantiations have the same name as the module name. 
This is done to facilitate debugging since referencing module names in a hierarchical path will be straightforward 
if the instance names match the module names.

## fifomem.v 

The FIFO memory buffer is typically an instantiated ASIC or FPGA dual-port, synchronous memory device. The
memory buffer could also be synthesized to ASIC or FPGA registers using the RTL code in this module.

## sync_r2w.v

This is a simple synchronizer module, used to pass an n-bit pointer from the read clock domain to the write clock
domain, through a pair of registers that are clocked by the FIFO write clock.

## sync_w2r.v

This is a simple synchronizer module, used to pass an n-bit pointer from the write clock domain to the read clock
domain, through a pair of registers that are clocked by the FIFO read clock.



