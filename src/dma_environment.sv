class dma_env extends uvm_env;
 
`uvm_component_utils(dma_env)
 dma_agent agt;
 dma_reg_block regbk;
 dma_adapter adapter;
 dma_subscriber sub;
 uvm_reg_predictor #(dma_sequence_item) predictor;

function new(string name = "dma_env", uvm_component parent);
	super.new(name, parent);
endfunction : new

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	predictor = uvm_reg_predictor#(dma_sequence_item)::type_id::create("predictor", this);
	agt = dma_agent::type_id::create("agt", this);
	sub = dma_subscriber::type_id::create("sub", this);
	regbk = dma_reg_block::type_id::create("regbk", this);
	adapter = dma_adapter::type_id::create("adapter");
	regbk.set_hdl_path_root("top.DUT");
	regbk.build();
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	agt.mon.mon_port.connect(sub.mon_import);
	regbk.default_map.set_sequencer( .sequencer(agt.seqr), .adapter(adapter) );
	regbk.default_map.set_base_addr(0);
	predictor.map = regbk.default_map;
	predictor.adapter = adapter;
	agt.mon.mon_port.connect(predictor.bus_in);
	regbk.default_map.set_auto_predict(0);
endfunction

endclass
