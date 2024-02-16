`timescale 1ns/1ps
`include "macros.v"
module moquanmips_min_sopc_tb();
    reg CLOCK_50;
    reg rst;
    
    //每隔10ns, CLOCK_50翻轉一次 50Hz
    initial begin
        CLOCK_50 = 1'b0;
        forever #10 CLOCK_50 = ~CLOCK_50;
    end
    initial begin
        rst = `RstEnable;
        #195 rst = `RstDisable;
        #1000 $stop;
    end
    //例化
    moquanmips_min_sopc moquanmips_min_sopc0(
        .clk(CLOCK_50),
        .rst(rst)
    );
endmodule