class dma_test extends uvm_test; 
	
	`uvm_component_utils(dma_test) 
	dma_env env; 
	dma_report_server srv; 
	
	function new(string name = "dma_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction : new 
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		env = dma_env::type_id::create("dma_env", this); 
		srv = new(); 
		uvm_report_server::set_server(srv);
	endfunction : build_phase 
	
	function void end_of_elaboration(); 
		uvm_top.print_topology();
	endfunction 

endclass


class dma_ctrl_test extends dma_test;
	ctrl_seq ct_seq;
	`uvm_component_utils(dma_ctrl_test) 
	
	function new(string name = "dma_ctrl_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		ct_seq = ctrl_seq::type_id::create("ct_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		ct_seq.regbk = env.regbk; 
		ct_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass



