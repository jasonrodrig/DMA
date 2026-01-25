class dma_subscriber extends uvm_component;

	`uvm_component_utils(dma_subscriber)
	uvm_analysis_imp#(dma_sequence_item, dma_subscriber) mon_import;
	dma_sequence_item mon_sig;
	real coverage_results;

	covergroup cvgrp;
		option.per_instance = 1;
		reset_cp  : coverpoint mon_sig.rst_n { bins b1   = { 0 , 1 };}
		wr_en_cp  : coverpoint mon_sig.wr_en { bins b2[] = { 0 , 1 };}
		rd_en_cp  : coverpoint mon_sig.rd_en { bins b3[] = { 0 , 1 };}
		wdata_cp  : coverpoint mon_sig.wdata { bins b5   = { [ 0 : $ ] };} 
		rdata_cp  : coverpoint mon_sig.rdata { bins b6   = { [ 0 : $ ] };}
		addr_cp   : coverpoint mon_sig.addr  {
			bins intr_addr            = {[1024:1027]};
			bins ctrl_addr            = {[1028:1031]};
			bins io_addr              = {[1032:1035]};
			bins mem_addr             = {[1036:1039]};
			bins extra_info_addr      = {[1040:1043]};
			bins status_addr          = {[1044:1047]};
			bins transfer_count_addr  = {[1048:1051]};
			bins descriptor_addr      = {[1052:1055]};
			bins error_status_addr    = {[1056:1059]};
			bins configure_addr       = {[1060:1064]};
		//  ignore_bins other_addr1[] = {[0:1023]};
    //	ignore_bins other_addr2[] = {[1065:$]};
		}
		
//		rd_en_cpxwr_en_cp: cross rd_en_cp , wr_en_cp{
//		 ignore_bins ignore_write_disbale = binsof(wr_en_cp) intersect {1} && binsof(rd_en_cp) intersect {0};
//    ignore_bins ignore_read_disbale  = binsof(rd_en_cp) intersect {0} && binsof(wr_en_cp) intersect {1};
//		}
	
	endgroup

	function new(string name = "dma_subscriber", uvm_component parent);
		super.new(name, parent);
		cvgrp = new();
		mon_import = new("mon_import", this);
	endfunction

	function void write(dma_sequence_item mon);
		mon_sig = mon;
		cvgrp.sample();
	endfunction

	function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
		coverage_results = cvgrp.get_coverage();
	endfunction

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(), $sformatf("[SUBSCRIBER] Coverage ------> %0.2f%%,", coverage_results), UVM_MEDIUM);
	endfunction

endclass
