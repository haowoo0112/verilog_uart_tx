`timescale 1ns/1ns
module uart_tx(
	input clk_50M,
	input reset,
	input write,
	input [7:0] write_value,
	output reg uart_txd = 1'b1
);

reg [12:0] bound9600_reg;
reg [7:0]value;
reg [3:0]send_counter;
reg tx_flag=1'b0;
wire bound9600,write_n;

always@(posedge clk_50M or negedge reset)
begin
	if(!reset)bound9600_reg=13'd0;
	else begin
		if(bound9600_reg == 13'd5208) bound9600_reg<=13'd0;
		else bound9600_reg <= bound9600_reg + 1'b1;
	end
end

always@(posedge clk_50M or negedge reset)
begin
	if(!reset)value=1'b0;
	else begin
		if(write_n) 
		begin
			value=write_value;
			tx_flag=1'b1;
		end
		else if(send_counter==4'd11)
			tx_flag=1'b0;
	end
end


always@(posedge clk_50M or negedge reset)
begin
	if(!reset)uart_txd=1'b1;
	else begin
		if(tx_flag==1'b1)
		begin
			if(bound9600)send_counter<=send_counter+1'b1;
			case(send_counter)
				4'd0: uart_txd=1'b1;
				4'd1: uart_txd=1'b0;
				4'd2: uart_txd=value[0];
				4'd3: uart_txd=value[1];
				4'd4: uart_txd=value[2];
				4'd5: uart_txd=value[3];
				4'd6: uart_txd=value[4];
				4'd7: uart_txd=value[5];
				4'd8: uart_txd=value[6];
				4'd9: uart_txd=value[7];
				4'd10: uart_txd=1'b1;
				default: uart_txd=1'b1;
			endcase
		end
		else
			send_counter=4'd0;
	end
end

edge_detect u1(.clk(clk_50M),.rst_n(reset),.data_in(bound9600_reg[11]),.neg_edge(bound9600));
edge_detect u2(.clk(clk_50M),.rst_n(reset),.data_in(write),.neg_edge(write_n));
endmodule
