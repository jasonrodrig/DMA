class dma_monitor extends uvm_monitor;

	virtual dma_interface.MONITOR vif;
	`uvm_component_utils(dma_monitor)
	uvm_analysis_port#(dma_sequence_item) mon_port;
	dma_sequence_item seq;

	function new(string name = "dma_monitor", uvm_component parent);
		super.new(name, parent);
		mon_port = new("mon_port",this);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_sequence_item::type_id::create("seq");
		if(!uvm_config_db#(virtual dma_interface)::get(this,"","vif", vif))
			`uvm_fatal("NO_VIF",{"virtual interface must be set for: DMA_MONITOR ",get_full_name(),".vif"});
	endfunction

	task run_phase(uvm_phase phase);
		forever begin  
			dma_monitor_code();  
		end
	endtask

	task dma_monitor_code();    
		repeat(3) @(vif.dma_monitor_cb);
		seq.rst_n = vif.dma_monitor_cb.rst_n ;
		seq.wr_en = vif.dma_monitor_cb.wr_en ;
		seq.rd_en = vif.dma_monitor_cb.rd_en ;
		seq.addr  = vif.dma_monitor_cb.addr  ;
		seq.wdata = vif.dma_monitor_cb.wdata ;
		seq.rdata = vif.dma_monitor_cb.rdata ;
		mon_port.write(seq);
	endtask

endclass
