module fifomem #(parameter DATASIZE = 8, // Memory data word width
parameter ADDRSIZE = 6) // Number of mem address bits
(output [DATASIZE-1:0] rdata,
output reg wr_ack,
output rd_valid,
input wclk,
input [DATASIZE-1:0] wdata,
input [ADDRSIZE-1:0] waddr, raddr,
input winc, wfull,
input rinc, rempty
);


localparam DEPTH = 1<<ADDRSIZE;
reg [DATASIZE-1:0] mem [0:DEPTH-1];


assign rdata    = (rinc & ~rempty)? mem[raddr] : 8'bz;
assign rd_valid = (rinc & ~rempty)? 1'b1 : 1'b0;


always @(posedge wclk)
	begin
	wr_ack<=1'b0;
	if (winc && !wfull) 
		begin
			mem[waddr] <= wdata;
			wr_ack<=1'b1;
		end
	end


endmodule
