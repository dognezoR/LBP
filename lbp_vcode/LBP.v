module LBP ( clk, reset, gray_addr, gray_req, gray_data, lbp_addr, lbp_write, lbp_data, finish);
input    clk;
input    reset;
output  reg [5:0]  gray_addr;
output  reg        gray_req;
input   [7:0]  gray_data;
output reg  [5:0]  lbp_addr;
output   reg lbp_write;
output reg  [7:0]  lbp_data;
output   reg finish;

parameter INIT      = 4'b0000;
parameter GRAY_ADDR = 4'b0001;
parameter LBP_CAL   = 4'b0010;
parameter LBP_WEIGHT = 4'b0011;
parameter LBP_WRITE = 4'b0100;
parameter FINISH    = 4'b0101;


//reg [7:0] image_buffer [63:0] ;
reg [3:0] state ,next_state;
reg [7:0] lbp_data1,lbp_data2,lbp_data3,lbp_data4,lbp_data5,lbp_data6,lbp_data7,lbp_data8,lbp_data9;
//reg [5:0] lbp_addr1, lbp_addr2, lbp_addr3, lbp_addr4, lbp_addr5, lbp_addr6, lbp_addr7, lbp_addr8, lbp_addr9;
reg lbp_w1,lbp_w2,lbp_w4,lbp_w8,lbp_w16,lbp_w32,lbp_w64,lbp_w128;
reg [3:0] read_count;
wire [5:0] addr1,addr2,addr3,addr4,addr5,addr6,addr7,addr8,addr9;
//////////////////////////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge reset) begin
    if(reset) begin
        state <= INIT;
    end
    else begin
        state <= next_state;
    end
end
//////////////////////////////////////////////////////////////////////////////////////////
always@(*) begin
    case (state)
        INIT        : next_state = GRAY_ADDR; 
        GRAY_ADDR   : if(read_count == 4'b1010) next_state = LBP_CAL; else next_state = GRAY_ADDR;
        LBP_CAL     : next_state = LBP_WEIGHT;
        LBP_WEIGHT  : next_state = LBP_WRITE ;
        LBP_WRITE   : if(lbp_addr == 6'b110110) next_state = FINISH; else next_state = GRAY_ADDR; 
                     
        FINISH      : next_state = FINISH   ;
        default: next_state = state;
    endcase
end
//////////////////////////////////////////////////////////////////////////////////////////

// gray addr 隨clock 改變
always @(posedge clk ) begin
    case (state)
        INIT        :   lbp_addr <=6'b001001;
        LBP_WRITE   :  begin
                        if(lbp_addr[2:0]==3'b110) lbp_addr <= lbp_addr + 6'b000011;
                        else lbp_addr <= lbp_addr + 6'b000001;
                      end 
        

        default: lbp_addr <=lbp_addr;
    endcase
end

always @(posedge clk ) begin
    if(state == INIT)  
    
            read_count <=4'b0;

    else if(state == GRAY_ADDR)

            read_count <= read_count +4'b1;

    else begin

            read_count <=4'b0;

    end
end
///////////////////////////////////////////////////////////////////////////////
assign addr1 = lbp_addr-6'b001001;
assign addr2 = lbp_addr-6'b001000;
assign addr3 = lbp_addr-6'b000111;
assign addr4 = lbp_addr-6'b000001;
assign addr5 = lbp_addr;
assign addr6 = lbp_addr+6'b000001;
assign addr7 = lbp_addr+6'b000111;
assign addr8 = lbp_addr+6'b001000;
assign addr9 = lbp_addr+6'b001001;

always @(posedge clk ) begin
    case (read_count)
        4'b0001: gray_addr <= addr1;
        4'b0010: gray_addr <= addr2;
        4'b0011: gray_addr <= addr3;
        4'b0100: gray_addr <= addr4;
        4'b0101: gray_addr <= addr5;
        4'b0110: gray_addr <= addr6;
        4'b0111: gray_addr <= addr7;
        4'b1000: gray_addr <= addr8;
        4'b1001: gray_addr <= addr9;
        default: begin end
    endcase
end

always @(posedge clk ) begin
    case (read_count)
        4'b0010: lbp_data1 <= gray_data;
        4'b0011: lbp_data2 <= gray_data;
        4'b0100: lbp_data3 <= gray_data;
        4'b0101: lbp_data4 <= gray_data;
        4'b0110: lbp_data5 <= gray_data;
        4'b0111: lbp_data6 <= gray_data;
        4'b1000: lbp_data7 <= gray_data;
        4'b1001: lbp_data8 <= gray_data;
        4'b1010: lbp_data9 <= gray_data;
        default: begin end
    endcase
end
///////////////////////////////////////////////////////////////
always @(posedge clk ) begin
    case (state)
        INIT : begin
                lbp_w1      <=1'b0;
                lbp_w2      <=1'b0;
                lbp_w4      <=1'b0;
                lbp_w8      <=1'b0;
                lbp_w16     <=1'b0;
                lbp_w32     <=1'b0;
                lbp_w64     <=1'b0;
                lbp_w128    <=1'b0;
        end
        LBP_CAL:  begin
                lbp_w1 <= (lbp_data1>=lbp_data5)?   1'b1:0;
                lbp_w2 <= (lbp_data2>=lbp_data5)?   1'b1:0;
                lbp_w4 <= (lbp_data3>=lbp_data5)?   1'b1:0;
                lbp_w8 <= (lbp_data4>=lbp_data5)?   1'b1:0;
                lbp_w16 <= (lbp_data6>=lbp_data5)?  1'b1:0;
                lbp_w32 <= (lbp_data7>=lbp_data5)?  1'b1:0;
                lbp_w64 <= (lbp_data8>=lbp_data5)?  1'b1:0;
                lbp_w128 <= (lbp_data9>=lbp_data5)? 1'b1:0;
                
        end
        default: begin end
    endcase
end
always @(posedge clk ) begin
    case (state)
    
        LBP_WEIGHT: begin
                lbp_data <= {lbp_w128,lbp_w64,lbp_w32,lbp_w16,lbp_w8,lbp_w4,lbp_w2,lbp_w1};
        end
        default: begin end
    endcase
end


///////////////////////////////////////////////////////////////
always @(*) begin
    case (state)
        INIT:begin 
            gray_req    = 0 ;
            lbp_write   = 0 ;
            finish      = 0 ; 
            end 
        GRAY_ADDR:begin 
            gray_req    = 1 ;
            lbp_write   = 0 ;
            finish      = 0 ; 
            end 
        LBP_CAL:begin 
            gray_req    = 0 ;
            lbp_write   = 0 ;
            finish      = 0 ; 
            end
        LBP_WEIGHT:begin 
            gray_req    = 0 ;
            lbp_write   = 0 ;
            finish      = 0 ; 
            end        
        LBP_WRITE:begin 
            gray_req    = 0 ;
            lbp_write   = 1 ;
            finish      = 0 ; 
            end
        FINISH:begin 
            gray_req    = 0 ;
            lbp_write   = 0 ;
            finish      = 1 ; 
            end                           
        default: begin
                 gray_req    = 0 ;
                 lbp_write   = 0 ;
                 finish      = 0 ; 
        end
    endcase
end

endmodule
