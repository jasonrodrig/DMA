`include "dma_defines.sv"
//`include "dma_design.sv"
`include "dma_interface.sv"
`include "dma_packages.sv"
import uvm_pkg::*;
import dma_pkg::*;

module top;

	bit clk = 0;
	always #5 clk = ~clk;

	dma_interface vif(clk);
/*
	dma DUT(
		.clk(vif.clk),
		.rst_n(vif.rst_n),
		.wr_en(vif.wr_en),
		.rd_en(vif.rd_en),
		.addr(vif.addr),
		.wdata(vif.wdata),
		.rdata(vif.rdata)
	);
*/
	initial begin 
		uvm_config_db#(virtual dma_interface)::set(null,"*","vif",vif);
		uvm_config_db#(int)::set(null,"*","include_coverage", 0);
		$dumpfile("wave.vcd");
		$dumpvars;
	end

	initial begin 
	//	run_test("dma_intr_test");
  //	run_test("dma_ctrl_test");
	//	run_test("dma_io_addr_test");
		run_test("dma_mem_addr_test");
	// 	run_test("dma_extra_info_test");
	//	run_test("dma_status_test");
	//	run_test("dma_transfer_count_test");
	//	run_test("dma_descriptor_addr_test");
	//	run_test("dma_error_status_test");
	//	run_test("dma_configiure_test");

	//	run_test("dma_regression_test");
		#1000 $finish;
	end

endmodule
