`timescale 1ns / 1ps

`include "constant.v"
module scanctl(
  ssd_ctl, // ssd display control signal 
  ssd_in, // output to ssd display
  in0, // 1st input
  in1, // 2nd input
  in2, // 3rd input
  in3,  // 4th input
  counter_num,
  mode_selection,
  clk_ssd // divided clock for scan control
);

output [`BCD_BIT_WIDTH-1:0] ssd_in; // Binary data 
output [`SSD_NUM-1:0] ssd_ctl; // scan control for 7-segment display
input [`BCD_BIT_WIDTH-1:0] in0, in1, in2, in3; // binary input control for the four digits 
input [3:0] counter_num;
input mode_selection;
input [1:0] clk_ssd; // divided clock for scan control

reg [`SSD_NUM-1:0] ssd_ctl; // scan control for 7-segment display (in the always block)
reg [`BCD_BIT_WIDTH-1:0] ssd_in; // 7 segment display control (in the always block)

always @*
if (~mode_selection) begin
  case (clk_ssd)
    2'b00: 
    begin
      ssd_ctl = 4'b0111;
      ssd_in = in0;
    end
    2'b01: 
    begin
      ssd_ctl = 4'b1011;
      ssd_in = in1;
    end
    2'b10: 
    begin
      ssd_ctl = 4'b1101;
      ssd_in = in2;
    end
    2'b11: 
    begin
      ssd_ctl = 4'b1110;
      ssd_in = in3;
    end
    default: 
    begin
      ssd_ctl=4'b0000;
      ssd_in=in0;
    end
  endcase
end
else begin
  case (clk_ssd)
    2'b00: 
    begin
      ssd_ctl = 4'b0111;
      ssd_in = 4'd0;
    end
    2'b01: 
    begin
      ssd_ctl = 4'b1011;
      ssd_in = 4'd0;
    end
    2'b10: 
    begin
      ssd_ctl = 4'b1101;
      ssd_in = 4'd0;
    end
    2'b11: 
    begin
      ssd_ctl = 4'b1110;
      ssd_in = counter_num;
    end
    default: 
    begin
      ssd_ctl = 4'b0000;
      ssd_in = 4'd0;
    end
  endcase
end
endmodule
