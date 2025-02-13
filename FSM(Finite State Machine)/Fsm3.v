module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    // State transition logic
    
    parameter [1:0] a=0, b=1, c=2, d=3;
    reg [1:0]state,next_state;
    
    always_comb 
        begin
        case(state)
            a:next_state=in?b:a;
            b:next_state=in?b:c;
            c:next_state=in?d:a;
            d:next_state=in?b:c;
        endcase
    end

    // State flip-flops with asynchronous reset
    //these conditions are always common to all the clock and reset signals
    always@(posedge clk or posedge areset)
        begin
            if(areset)
                state<=a;
            else
                state<=next_state;
        end
    
    // Output logic
    
   assign out = (state == d);
endmodule
