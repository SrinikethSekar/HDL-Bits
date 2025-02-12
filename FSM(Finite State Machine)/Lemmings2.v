module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter [1:0] LEFT=0, RIGHT=1, FALL_L=2, FALL_R=3;
    reg [1:0] state, next_state;

    always @(*) begin
        case(state)
            LEFT: next_state = ground?(!bump_left ?LEFT:RIGHT):FALL_L;		
            RIGHT: next_state = ground?(!bump_right ?RIGHT:LEFT):FALL_R; 
            FALL_R: next_state = !ground?FALL_R:RIGHT;
            FALL_L: next_state = !ground?FALL_L:LEFT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state<=LEFT;
        else
            state<=next_state;
    end

    
    assign walk_left   = (state == LEFT );
    assign walk_right  = (state == RIGHT);
    assign aaah        = (state == FALL_R)||(state == FALL_L);
endmodule

