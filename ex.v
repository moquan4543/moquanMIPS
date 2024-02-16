`include "macros.v"
module ex(
    input wire rst,

    //譯碼階段傳遞過來的訊號
    input wire[`AluOpBus] aluop_i,
    input wire[`AluSelBus] alusel_i,
    input wire[`RegBus] reg1_i,
    input wire[`RegBus] reg2_i,
    input wire[`RegAddrBus] wd_i,
    input wire wreg_i,

    //執行結果
    output reg[`RegAddrBus] wd_o,
    output reg wreg_o,
    output reg[`RegBus] wdata_o
);
    //儲存運算結果
    reg[`RegBus] logicout;

    //Step.1 根據aluop_i指定的子運算類型進行運算
    always @ (*) begin
        if(rst == `RstEnable) begin
            logicout <= `ZeroWord;
        end else begin
            case (aluop_i)
            `EXE_OR_OP: begin
                logicout <= reg1_i | reg2_i;
            end
            default:begin
                logicout <= `ZeroWord;
            end
            endcase
        end
    end

    //Step.2 根據alusel_i指定的運算類型，選擇運算結果
    always @ (*) begin
        wd_o <= wd_i;
        wreg_o <= wreg_i;
        case (alusel_i)
        `EXE_RES_LOGIC: begin
            wdata_o <= logicout;
        end
        default:begin
            wdata_o <= `ZeroWord;
        end
        endcase
    end
endmodule