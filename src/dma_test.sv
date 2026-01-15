class dma_test extends uvm_test;

	dma_env env;
	dma_reg_seq rseq;
	dma_report_server srv;
	`uvm_component_utils(dma_test)

	function new(string name = "test", uvm_component parent);
		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = dma_env::type_id::create("env",this);
		rseq = dma_reg_seq::type_id::create("rseq");
		srv = new();
		uvm_report_server::set_server(srv);
	endfunction

	function void end_of_elaboration();
		uvm_top.print_topology();
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		rseq.regbk = env.regbk;
		rseq.start(env.agt.seqr);
		phase.drop_objection(this);
		//	phase.phase_done.set_drain_time(this, 20);
	endtask

endclass
