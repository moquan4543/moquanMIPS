`include "macros.v"
module regfile(
	input wire clk,
	input wire rst,
	
	
	//write port
	input wire we,
	input wire[`RegAddrBus] waddr,
	input wire[`RegBus] wdata,
	
	//read port
	input wire re1,
	input wire[`RegAddrBus] raddr1,
	output reg[`RegBus] rdata1,
	
	//read port2
	input wire re2,
	input wire[`RegAddrBus] raddr2,
	output reg[`RegBus] rdata2
);

	//32個32位寄存器
	reg[`RegBus] regs[0:`RegNum-1];
	
	//寫操作
	always @ (posedge clk) begin
		if(rst == `RstDisable) begin
			if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin
				regs[waddr] <= wdata;
			end
		end
	end
	
	//讀port 1
	always @ (*) begin
		if(rst == `RstEnable) begin
			rdata1 <= `ZeroWord;
		end else if(raddr1 == `RegNumLog2'h0)begin //讀取的是$0
			rdata1 <= `ZeroWord;
		end else if((raddr1 == waddr) && (we == `WriteEnable) && (re1 == `ReadEnable)) begin //讀、寫為相同寄存器
			rdata1 <= wdata;
		end else if(re1 == `ReadEnable) begin
			rdata1 <= regs[raddr1];
		end else begin
			rdata1 <= `ZeroWord;
		end
	end
	
	//讀port 2
	always @ (*) begin
		if(rst == `RstEnable) begin
			rdata2 <= `ZeroWord;
		end else if(rdata2 == `RegNumLog2'h0) begin
			rdata2 <= `ZeroWord;
		end else if((raddr2 == waddr) && (we == `WriteEnable) && (re2 == `ReadEnable)) begin
			rdata2 <= wdata;
		end else if(re2 == `ReadEnable) begin
			rdata2 <= regs[raddr2];
		end else begin
			rdata2 <= `ZeroWord;
		end
	end
endmodule