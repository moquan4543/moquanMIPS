`include "macros.v"
module moquanmips_min_sopc (
    input wire clk,
    input wire rst
);

    //連接inst_rom的變數
    wire[`InstAddrBus] inst_addr;
    wire[`InstBus] inst;
    wire rom_ce;

    //例化moquan MIPS
    moquanmips moquanmips0(
        .clk(clk), .rst(rst),
        .rom_addr_o(inst_addr), .rom_data_i(inst),
        .rom_ce_o(rom_ce)
    );

    //例化rom
    inst_rom inst_rom0(
        .ce(rom_ce),
        .addr(inst_addr), .inst(inst)
    );
endmodule