//以byte尋址
`include "macros.v"
module inst_rom(
    input wire ce,
    input wire[`InstAddrBus] addr,
    output reg[`InstBus] inst
);
    reg[`InstBus] inst_mem[0:`InstMemNum-1];

    //初始化指令存儲器
    initial $readmemh ( "inst_rom.data", inst_mem);

    //根據輸入的位址，輸出元素
    always @ (*) begin
        if(ce == `ChipDisable) begin
            inst <= `ZeroWord;
        end else begin
            inst <= inst_mem[addr[`InstMemNumLog2+1:2]];
        end
    end
endmodule