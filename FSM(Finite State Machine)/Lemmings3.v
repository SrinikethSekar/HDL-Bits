module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter [2:0] LEFT=3'b000, RIGHT=3'b001, FALL_L=3'b010, FALL_R=3'b011,DIG_L=3'b100,DIG_R=3'b101;
    reg [2:0] state, next_state;

    always @(*) begin
        case(state)
            //LEFT: next_state = dig?(ground?(!bump_left ?LEFT:RIGHT):FALL_L):DIG_L;		
             LEFT:begin
                 if(!ground)
                     next_state = FALL_L;
                 else if(ground && dig)
                     next_state = DIG_L;
                 else if(bump_left)
                     next_state = RIGHT;
                 else
                     next_state = LEFT;
             end
    
           //RIGHT: next_state = dig?(ground?(!bump_right ?RIGHT:LEFT):FALL_R):DIG_R; 
              RIGHT:begin
                 if(!ground)
                     next_state = FALL_R;
                 else if(ground && dig)
                     next_state = DIG_R;
                  else if(bump_right)
                     next_state = LEFT;
                 else
                     next_state = RIGHT;
             end
            //FALL_R: next_state = !ground?FALL_R:RIGHT;
             FALL_R:begin
                 if(!ground)
                     next_state = FALL_R;
                 else
                     next_state = RIGHT;
             end
            
            //FALL_L: next_state = !ground?FALL_L:LEFT;
              FALL_L:begin
                 if(!ground)
                     next_state = FALL_L;
                 else
                     next_state = LEFT;
             end
            
            //DIG_R:next_state=!ground?FALL_R:DIG_R;
              DIG_L:begin
                 if(!ground)
                     next_state = FALL_L;
                 else
                     next_state = DIG_L;
             end
            
           
            // DIG_L:next_state=!ground?FALL_L:DIG_L;
        	  DIG_R:begin
                 if(!ground)
                     next_state = FALL_R;
                 else
                     next_state = DIG_R;
             end
        
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
    assign digging     = (state == DIG_R)||(state == DIG_L);
endmodule



