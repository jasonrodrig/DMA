`include "dma_defines.sv"
`include "dma_design.sv"
`include "dma_interface.sv"
`include "dma_packages.sv"
import uvm_pkg::*;
import dma_pkg::*;

module top;

	bit clk = 0;
	always #5 clk = ~clk;

	dma_interface vif(clk);

	dma DUT(
		.clk(vif.clk),
		.rst_n(vif.rst_n),
		.wr_en(vif.wr_en),
		.rd_en(vif.rd_en),
		.addr(vif.addr),
		.wdata(vif.wdata),
		.rdata(vif.rdata)
	);

	initial begin 
		uvm_config_db#(virtual dma_interface)::set(null,"*","vif",vif);
		uvm_config_db#(int)::set(null,"*","include_coverage", 0);
		$dumpfile("wave.vcd");
		$dumpvars;
	end

	initial begin 
		run_test("dma_test");
		#1000 $finish;
	end

endmodule
