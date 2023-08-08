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
