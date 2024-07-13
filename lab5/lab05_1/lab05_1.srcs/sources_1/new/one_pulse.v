`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/27 02:35:33
// Design Name: 
// Module Name: one_pulse
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module one_pulse(
    input clk,
    input rst_n,
    input in_trig,
    output out_pulse
    );
    
    reg out_pulse; // output one pulse 
    // Declare internal nodes 
    reg in_trig_delay; 
    
    // Buffer input 
    always @(posedge clk or negedge rst_n) 
        if (~rst_n) 
            in_trig_delay <= 1'b0; 
        else 
            in_trig_delay <= in_trig;
    // Pulse generation 
    assign out_pulse_next = in_trig & (~in_trig_delay); 
    always @(posedge clk or negedge rst_n) 
        if (~rst_n) 
            out_pulse <= 1'b0; 
        else 
            out_pulse <= out_pulse_next; 

endmodule
