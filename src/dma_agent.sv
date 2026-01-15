class dma_agent extends uvm_agent;

	`uvm_component_utils(dma_agent)
	dma_driver driv;
	dma_sequencer seqr;
	dma_monitor mon;

	function new(string name = "dma_agent", uvm_component parent );
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		driv = dma_driver::type_id::create("driv",this);
		mon  = dma_monitor::type_id::create("mon",this);
		seqr = dma_sequencer::type_id::create("seqr", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		driv.seq_item_port.connect(seqr.seq_item_export);
	endfunction

endclass
