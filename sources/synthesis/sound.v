/*#############################################################################\
##                                                                            ##
##       APPLIED ELECTRONICS - Physics Department - University of Padova      ##
##                                                                            ## 
##       ---------------------------------------------------------------      ##
##                                                                            ##
##                           Traffic light example                            ##
##                                                                            ##
\#############################################################################*/

// INFO
// The light module transforms a 2-bit signal (4 states) into a color-coded
// output for the Arty board.


// -----------------------------------------------------------------------------
// --                                PARAMETERS                               --
// -----------------------------------------------------------------------------
//
// C_CLK_FRQ:       frequency of the clock in [cycles per second] {100000000}. 
// C_INTERVAL:      the time interval the signal must be stable to pass through
//					and reach the fabric. [ms] {10}.


// -----------------------------------------------------------------------------
// --                                I/O PORTS                                --
// -----------------------------------------------------------------------------
//
// rstb:                INPUT, synchronous reset, ACTIVE LOW. 
// clk:                 INPUT, master clock.
// in [1 : 0]:          INPUT, the light state signal.
// out_LED [11 : 0]:    OUTPUT: the signal toward the board RGB LEDs.
//                              each LED is RGB and used 3 bit to encode the color.

// Tool timescale.
`timescale 1 ns / 1 ps

// Behavioural.
module  sound # (
		parameter C_CLK_FRQ = 100_000_000, 	  // Clock frequency [Hz].
		parameter C_FREQ = 1                // Frequency of generated sound.
	) (
		input rstb,               // Reset (bar).  
		input clk,                // Clock.
		input in,        // Selection (sound status).
		output out    // Output Sound to fabric.
	);


	// =========================================================================
    // ==                       Parameters derivation                         ==
    // =========================================================================

 
    //localparam C_CYCLES = C_CLK_FRQ / C_FREQ;
    
    localparam C_CYCLES_WIDTH = 20;            // Width of counter reg, it should be big enough to be able to reach C_Max
    localparam C_Max = (C_CLK_FRQ/C_FREQ)/2;   //C_Max represent number of cycles sound signal is H or L (half period)
   

   	// =========================================================================
    // ==                        Registers and wires                          ==
    // =========================================================================

	// Counters.
	reg [C_CYCLES_WIDTH - 1 : 0] rCount;
	reg speaker;
	
	
	// =========================================================================
    // ==                      Asynchronous assignments                       ==
    // =========================================================================

	// XOR of the thwo FF to generate counter reset signal.
	assign out = speaker;
	
	
	// =========================================================================
    // ==                        Synchronous counters                         ==
    // =========================================================================

	// Increments the counter if the signal is stable
	always @ (posedge clk) begin
		
		// Reset the counter.
		if (rstb ==  1'b0) begin
			rCount <= { C_CYCLES_WIDTH {1'b0} };
        
		// Count.
		end else if (in == 1'b1) begin
		    if (rCount == C_Max) begin
		      rCount <= 0;
		      speaker <=  ~speaker;
		    end else begin
		      rCount <= rCount + 1;  
		    end
		end else if (in == 1'b0) begin
		    rCount <= { C_CYCLES_WIDTH {1'b0} };  //Set Counter to zero when in=0
		    speaker <= 0;
		end 
	end


	
endmodule


