module buffer4x8(
	input clk,
	input [7:0] b,
	input shl,
	input [1:0] bufdestino,
	input [1:0] muxd,
	output [7:0] salida
);

	reg [7:0] buff[3:0]; 
	reg [7:0] buf1;

	assign salida=buf1;

	always @(posedge clk) begin
		if(shl) begin /* corrimiento */
			buff[3]<=buff[2];
			buff[2]<=buff[1];
			buff[1]<=buff[0];
			buff[0]<=b;
		end	/* fin de corrimiento */
		else begin /* inicializacion */
			buff[bufdestino]<=b;
		end	/* fin de inicializacion */
	end

	always @(posedge clk) begin
		case(muxd)
			0:buf1<=buff[0];
			1:buf1<=buff[1];
			2:buf1<=buff[2];
			3:buf1<=buff[3];
		endcase
	end

endmodule


module buffer4x8_tb();
	reg clk;
	reg [7:0] b;
	reg shl;
	reg [1:0] bufdestino;
	reg [1:0] muxd;
	wire [7:0] salida;

	initial forever #20 clk=~clk;

	initial #400 $finish;


	initial begin
		clk=0;
		b=8'b0;
		shl=0;
		bufdestino=2'b00;
		muxd=2'b00;

		#15;
		bufdestino=2'b00;
		b=8'd4;
		
		#40;
		bufdestino=2'b01;
		b=8'd3;
		
		#40;
		bufdestino=2'b10;
		b=8'd2;

		#40;
		bufdestino=2'b11;
		b=8'd1;
		
		#40; #40;
		// corrimiento
		shl=1;
		b=8'd7;

		#40 
		shl=0;
		bufdestino=2'b00;
		b=8'd7;
	end

	buffer4x8 U(clk, b, shl, bufdestino, muxd, salida);
	initial begin
		$display("time\tClk\tb3\tb2\tb1\tb0");
		$monitor("%4d\t%b\t%1d\t%1d\t%1d\t%1d",$time, clk, U.buff[3], U.buff[2], U.buff[1], U.buff[0]);
	end
endmodule

