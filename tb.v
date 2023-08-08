//`timescale 1ns/100ps
//`timescale <time_unit>/<time_precision>
// <time_unit> : specifies unit of time delay for e.g. #1 is 1ns
// <time_precision> : how delays are rounded of before being used in simulation e.g. #0.49 is 490ps approx to 500ps
// or <time_precision> :smallest amount by which simulation time can advance is #0.1 i.e 100 ps


// localparam : prevents value from being overwritten from outside.
//once a module is instantiated localparam values stays constant and can't be modified by defparam or module parameter value. 

// parameter : e.g module name #(parameter ASIZE =7) opposite of localparam.
// defparam : used in testbench simulatons to override parameter values,(which also gets overwritten in instantiation)
// Defparam overrides the parameter value at compile time.

`timescale 1ns/10ps
module tb;
	// INPUTS
	reg wclk,wrst_n,winc;
	reg [7:0]wdata;
	reg rclk,rrst_n,rinc;

	//OUTPUTS
	wire wfull,rempty,wr_ack,rd_valid;
	wire [7:0]rdata;

	fifo1 fifo1_DUT( //INPUTS
						 .wclk(wclk),.wrst_n(wrst_n), .winc(winc), .wdata(wdata), 
						 .rclk(rclk),.rrst_n(rrst_n), .rinc(rinc),
						 //OUTPUTS
						 .wfull(wfull),.rempty(rempty),.wr_ack(wr_ack),.rd_valid(rd_valid), 
						 .rdata(rdata)
						 );

always #6.25 wclk = ~wclk ; // write clock period is 12.5ns or 80 Mhz
always #10 rclk = ~rclk;   // read clock period is 20ns or 50 Mhz

initial begin
	wclk=1'b0;
	wrst_n=1'b0;
	winc=1'b0;
	#12.5 wrst_n=1'b1;
end

initial begin
	rclk=1'b0;
	rrst_n=1'b0;
	rinc=1'b0;
	#20 rrst_n=1'b1;
end

integer i;
initial begin
#12.5 
for(i=0;i<156;i=i+1)
	begin
	#12.5 
	wdata=(i+1);  // at 25ns first word will be written to FIFO
	winc=1'b1;
	end
#12.5 winc=1'b0;


#2800 $stop ;
end

initial begin
#25
rinc=1'b1;

end



endmodule
