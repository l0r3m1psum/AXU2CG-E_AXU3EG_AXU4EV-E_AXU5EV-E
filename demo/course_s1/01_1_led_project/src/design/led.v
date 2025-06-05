`timescale 1ns / 1ps
/* (* MARK_DEBUG="true" *) allows to view the signal in the Integrated Logic
 * Analyzer (ILA).
 */
module led(
//Differential system clock
    input sys_clk_p,
    input sys_clk_n,
    input [3:0] key,
// (* MARK_DEBUG="true" *)    output reg  led
    output reg [3:0] led
);

// (* MARK_DEBUG="true" *)reg[31:0] timer_cnt;
    reg[31:0] timer_cnt = 0;
    wire sys_clk;
    wire rst_n = key[0];

    IBUFDS IBUFDS_inst (
       .O(sys_clk),
       .I(sys_clk_p),
       .IB(sys_clk_n)
    );

    always@(posedge sys_clk) begin
        if (!rst_n) begin
          led[0] <= 1'b1 ;
          timer_cnt <= 32'd0 ;
        end else if (timer_cnt >= 32'd199_999_999) begin // 1 second counter
            led[0] <= ~led[0];
            timer_cnt <= 32'd0;
        end else begin
            led[0] <= led[0];
            timer_cnt <= timer_cnt + 32'd1;
        end
        led[1] <= 1;
        led[2] <= 1;
        led[3] <= 1;
    end

    //Instantiate ila in source file
    //ila ila_inst(
    //  .clk(sys_clk),
    //  .probe0(timer_cnt),
    //  .probe1(led)
    //  );
endmodule
