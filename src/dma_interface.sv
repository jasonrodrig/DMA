interface dma_interface(input bit clk);

	bit rst_n; 
  bit wr_en;
	bit rd_en;
	bit [ `DATA_WIDTH - 1 : 0 ] wdata ; 
	bit [ `ADDR_WIDTH - 1 : 0 ] addr  ;
  bit [ `DATA_WIDTH - 1 : 0 ] rdata ;

	clocking dma_driver_cb @(posedge clk);
		default input #0 output #0;
		output rst_n;
		output wr_en;
		output rd_en;
    output wdata;
    output addr;
		input  rdata;
	endclocking

  clocking dma_monitor_cb @(posedge clk);
		default input #0 output #0;
		input rst_n;
		input wr_en;
		input rd_en;
    input wdata;
    input addr;
    input rdata;
	endclocking

	modport DRIVER(clocking dma_driver_cb);
	modport MONITOR(clocking dma_monitor_cb);

endinterface
