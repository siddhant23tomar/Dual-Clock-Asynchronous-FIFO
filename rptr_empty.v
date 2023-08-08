module rptr_empty #(parameter ADDRSIZE = 6)
(output reg rempty,
output [ADDRSIZE-1:0] raddr,
output reg [ADDRSIZE :0] rptr,
input [ADDRSIZE :0] rq2_wptr,
input rinc, rclk, rrst_n);

reg [ADDRSIZE:0] rbin;
reg [ADDRSIZE:0] rgraynext, rbinnext;

wire rempty_val;
//assign rbinnext = rbin + 1;
//assign rgraynext = (rbinnext>>1) ^ rbinnext;
always@(*)
if((rinc & ~rempty))
	begin
		rbinnext  = rbin + 1'b1;
		rgraynext = (rbinnext>>1) ^ rbinnext;
	end
else
	begin
		rbinnext  = rbin;
		rgraynext = rptr;
	
	end





//-------------------
// GRAYSTYLE2 pointer
//-------------------
always @(posedge rclk or negedge rrst_n)
	if (!rrst_n) 
		begin
			rbin<= 0;
			rptr<= 0;
		end
		
	else  
		begin
			rbin <= rbinnext;
			rptr <= rgraynext;
		end
	
		

//---------------------------------------------------------------
// FIFO empty when the next rptr == synchronized wptr or on reset
//---------------------------------------------------------------
assign rempty_val = (rgraynext == rq2_wptr);
always @(posedge rclk or negedge rrst_n)
	if (!rrst_n) 
		rempty <= 1'b1;
	else 
		rempty <= rempty_val;
		
		
// Memory read-address pointer (okay to use binary to address memory)
assign raddr = rbin[ADDRSIZE-1:0];

endmodule
