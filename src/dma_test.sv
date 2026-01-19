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

class dma_reset_test extends dma_test;
	 reset_seq rst_seq;
	`uvm_component_utils(dma_reset_test) 
	
	function new(string name = "dma_reset_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		rst_seq = reset_seq::type_id::create("rst_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		rst_seq.regbk = env.regbk; 
		rst_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass

/*

class dma_intr_test extends dma_test;
	intr_seq it_seq;
	`uvm_component_utils(dma_intr_test) 
	
	function new(string name = "dma_intr_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		it_seq = intr_seq::type_id::create("it_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		it_seq.regbk = env.regbk; 
		it_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass
*/

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

class dma_io_addr_test extends dma_test;
	io_addr_seq io_seq;
	`uvm_component_utils(dma_io_addr_test) 
	
	function new(string name = "dma_io_addr_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		io_seq = io_addr_seq::type_id::create("io_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		io_seq.regbk = env.regbk; 
		io_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass

class dma_mem_addr_test extends dma_test;
	mem_addr_seq mem_seq;
	`uvm_component_utils(dma_mem_addr_test) 
	
	function new(string name = "dma_mem_addr_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		mem_seq = mem_addr_seq::type_id::create("mem_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		mem_seq.regbk = env.regbk; 
		mem_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass

class dma_extra_info_test extends dma_test;
	extra_info_seq ex_seq;
	`uvm_component_utils(dma_extra_info_test) 
	
	function new(string name = "dma_extra_info_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		ex_seq = extra_info_seq::type_id::create("extra_info_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		ex_seq.regbk = env.regbk; 
		ex_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass
/*
class dma_status_test extends dma_test;
	status_seq stat_seq;
	`uvm_component_utils(dma_status_test) 
	
	function new(string name = "dma_status_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		stat_seq = status_seq::type_id::create("stat_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		stat_seq.regbk = env.regbk; 
		stat_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass

class dma_transfer_count_test extends dma_test;
	transfer_count_seq trans_seq;
	`uvm_component_utils(dma_transfer_count_test) 
	
	function new(string name = "dma_transfer_count_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		trans_seq = transfer_count_seq::type_id::create("trans_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		trans_seq.regbk = env.regbk; 
		trans_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass
*/

class dma_descriptor_addr_test extends dma_test;
	descriptor_addr_seq des_seq;
	`uvm_component_utils(dma_descriptor_addr_test) 
	
	function new(string name = "dma_descriptor_addr_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		des_seq = descriptor_addr_seq::type_id::create("des_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		des_seq.regbk = env.regbk; 
		des_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass

/*
class dma_error_status_test extends dma_test;
	error_status_seq err_seq;
	`uvm_component_utils(dma_error_status_test) 
	
	function new(string name = "dma_error_status_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		err_seq = error_status_seq::type_id::create("err_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		err_seq.regbk = env.regbk; 
		err_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass
*/

class dma_configure_test extends dma_test;
	 configure_seq con_seq;
	`uvm_component_utils(dma_configure_test) 
	
	function new(string name = "dma_configure_test", uvm_component parent); 
		super.new(name,parent); 
	endfunction
	
	function void build_phase(uvm_phase phase); 
		super.build_phase(phase);
		con_seq = configure_seq::type_id::create("con_seq"); 
	endfunction
	
	task run_phase(uvm_phase phase); 
		phase.raise_objection(this);
		con_seq.regbk = env.regbk; 
		con_seq.start(env.agt.seqr); 
		phase.drop_objection(this); 
		// phase.phase_done.set_drain_time(this, 20); 
	endtask

endclass























