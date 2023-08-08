module wptr_full #(parameter ADDRSIZE = 6)
(output reg wfull,
output [ADDRSIZE-1:0] waddr,
output reg [ADDRSIZE :0] wptr,
input [ADDRSIZE :0] wq2_rptr,
input winc, wclk, wrst_n);

reg [ADDRSIZE:0] wbin;
reg [ADDRSIZE:0] wgraynext, wbinnext;

//correction
wire wfull_val;
// GRAYSTYLE2 pointer
//assign wbinnext = wbin + 1;
//assign wgraynext = (wbinnext>>1) ^ wbinnext;

always@(*)
if((winc & ~wfull))
	begin
		wbinnext  = wbin + 1'b1;
		wgraynext = (wbinnext>>1) ^ wbinnext;
	end
else
	begin
		wbinnext  = wbin;
		wgraynext = wptr;
	
	end





always @(posedge wclk or negedge wrst_n)
	if (!wrst_n) 
		{wbin, wptr} <= 0;
	else 
		{wbin, wptr} <= {wbinnext, wgraynext};
		


//------------------------------------------------------------------
// Simplified version of the three necessary full-tests:
// assign wfull_val=((wgnext[ADDRSIZE] !=wq2_rptr[ADDRSIZE] ) &&
// (wgnext[ADDRSIZE-1] !=wq2_rptr[ADDRSIZE-1]) &&
// (wgnext[ADDRSIZE-2:0]==wq2_rptr[ADDRSIZE-2:0]));
//------------------------------------------------------------------
// Compact version of the three necessary full-tests:
//assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1],wq2_rptr[ADDRSIZE-2:0]});

// assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1],wq2_rptr[ADDRSIZE-2:0]});
 assign wfull_val=(	(wgraynext[ADDRSIZE] 	 != wq2_rptr[ADDRSIZE] )    	&&
							(wgraynext[ADDRSIZE-1]   != wq2_rptr[ADDRSIZE-1]) 		&&
							(wgraynext[ADDRSIZE-2:0] == wq2_rptr[ADDRSIZE-2:0])
						);
						
always @(posedge wclk or negedge wrst_n)
	if (!wrst_n) 
		wfull <= 1'b0;
	else 
		wfull <= wfull_val;

// Memory write-address pointer (okay to use binary to address memory)
assign waddr = wbin[ADDRSIZE-1:0];

endmodule
