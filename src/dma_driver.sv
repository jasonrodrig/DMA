class dma_driver extends uvm_driver#(dma_sequence_item);

	virtual dma_interface.DRIVER vif;
	`uvm_component_utils(dma_driver)

	function new(string name = "dma_driver", uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual dma_interface)::get(this,"","vif", vif))
			`uvm_fatal("NO_VIF",{"virtual interface must be set for: DMA_DRIVER ",get_full_name(),".vif"});
	endfunction

	task run_phase(uvm_phase phase);
		forever begin  
			seq_item_port.get_next_item(req);
			dma_driver_code();   
			seq_item_port.item_done();
		end
	endtask

	task dma_driver_code();    
	  if(req.wr_en) begin //write operation
			vif.dma_driver_cb.wr_en <= 1;
			vif.dma_driver_cb.rd_en <= 0;
			vif.dma_driver_cb.rst_n <= 1;
			vif.dma_driver_cb.wdata <= req.wdata;
			vif.dma_driver_cb.addr  <= req.addr;
			//		  $display("driver write : rst_n = %b, wr_En = %b, rd_En = %B, addr = %d, wdata = %d, rdata = %d",
			//				req.rst_n, req.wr_en, req.rd_en, req.addr, req.wdata, req.rdata );
			repeat(2) @(vif.dma_driver_cb);
		end

		else if(req.rd_en) begin //read operation
			repeat(1) @(vif.dma_driver_cb);
			vif.dma_driver_cb.rd_en <= 1;
			vif.dma_driver_cb.rst_n <= 1;
			vif.dma_driver_cb.wr_en <= 0;
			vif.dma_driver_cb.addr  <= req.addr;
			vif.dma_driver_cb.wdata <= 0;
			repeat(1) @(vif.dma_driver_cb);
			req.rdata = vif.dma_driver_cb.rdata;  
			//			  $display("driver read : rst_n = %b, wr_En = %b, rd_En = %B, addr = %d, wdata = %d, rdata = %d",
			//					req.rst_n, req.wr_en, req.rd_en, req.addr, req.wdata, req.rdata );
		end

	endtask
endclass
