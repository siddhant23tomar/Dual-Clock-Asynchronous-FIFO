# Dual-Clock-Asynchronous-FIFO
Verilog Code of the FIFO based on the work of Clifford Cummings and its simulation specification.
## CITATION:
Clifford E. Cummings and Peter Alfke, “Simulation and Synthesis Techniques for Asynchronous FIFO Design with
Asynchronous Pointer Comparisons,” SNUG 2002 (Synopsys Users Group Conference, San Jose, CA, 2002) User Papers,
March 2002, Section TB2, 3rd paper. Also available at www.sunburst-design.com/papers
##  FIFO TOP LEVEL 
![alt text](https://github.com/siddhant23tomar/Dual-Clock-Asynchronous-FIFO/blob/main/FIFO_TOP_LEVEL.png?raw=true)


## Short Description of Verilog Files 

### fifo1.v 

The top-level FIFO module is a parameterized FIFO design with all sub-blocks instantiated using the recommended
practice of doing named port connections. The top-level module instantiations have the same name as the module name. 
This is done to facilitate debugging since referencing module names in a hierarchical path will be straightforward 
if the instance names match the module names.

### fifomem.v 

The FIFO memory buffer is typically an instantiated ASIC or FPGA dual-port, synchronous memory device. The
memory buffer could also be synthesized to ASIC or FPGA registers using the RTL code in this module.

## sync_r2w.v

This is a simple synchronizer module, used to pass an n-bit pointer from the read clock domain to the write clock
domain, through a pair of registers that are clocked by the FIFO write clock.

### sync_w2r.v

This is a simple synchronizer module, used to pass an n-bit pointer from the write clock domain to the read clock
domain, through a pair of registers that are clocked by the FIFO read clock.

### rptr_empty.v

This module encloses all of the FIFO logic that is generated within the read clock domain (except synchronizers).
The read pointer is a dual n-bit Gray code counter. The n-bit pointer ( rptr ) is passed to the write clock domain
through the sync_r2w module. The (n-1)-bit pointer ( raddr ) is used to address the FIFO buffer.

### wptr_empty.v

This module encloses all of the FIFO logic that is generated within the write clock domain (except synchronizers).
The write pointer is a dual n-bit Gray code counter. The n-bit pointer ( wptr ) is passed to the read clock domain
through the sync_w2r module. The (n-1)-bit pointer ( waddr ) is used to address the FIFO buffer.


### tb.v
This was the testbench used for verifying the functionality, of the FIFO of depth 64 and word size of one byte. The clock domains chosen are 50 MHz and 80 MHz
and burst length of 156 bytes.

## Simulation results

### read empty flag
![alt text](https://github.com/siddhant23tomar/Dual-Clock-Asynchronous-FIFO/blob/main/REMPTY.png?raw=true)

### write full flag

![alt text](https://github.com/siddhant23tomar/Dual-Clock-Asynchronous-FIFO/blob/main/WFULL.png?raw=true)
