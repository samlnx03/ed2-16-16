module mux_estructural(
	input i0, i1, s,
	output z
);

	wire nots, w1, w2;

	and U1(w1, nots, i0);
	and U2(w2, s, i1);
	or U3(z,w1,w2);
	not U4(nots, s);

endmodule

module mux_estructural_tb();
	wire z;
	reg i0,i1,s;

	mux_estructural M(i0,i1,s,z);

	initial begin
		$display("time\ti1\ti0\ts\tz");
		$monitor("%4d\t%b\t%b\t%b\t%b",$time,i1,i0,s,z);
		    i1=0; i0=0; s=0;
		#10 i1=0; i0=0; s=1;
		#10 i1=0; i0=1; s=0;
		#10 i1=0; i0=1; s=1;
		#10 i1=1; i0=0; s=0;
		#10 i1=1; i0=0; s=1;
		#10 i1=1; i0=1; s=0;
		#10 i1=1; i0=1; s=1;
	end
endmodule

