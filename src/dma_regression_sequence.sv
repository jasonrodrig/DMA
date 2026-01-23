class dma_regression_seq extends uvm_sequence;
	
	`uvm_object_utils(dma_regression_seq)
	
	dma_reg_block        regbk;
	reset_seq            rst_seq;
	intr_seq             int_seq;
	ctrl_seq             ct_seq;
	io_addr_seq          io_seq;	
  mem_addr_seq         mem_seq;
	extra_info_seq       info_seq;
  status_seq           stat_seq;
  transfer_count_seq   trans_seq;
	descriptor_addr_seq  des_seq;
	error_status_seq     err_seq;
	configure_seq        con_seq;

	function new (string name = "dma_regression_seq");
		super.new(name);
	endfunction

	task body();

		rst_seq    =  reset_seq::type_id::create("rst_seq");
		int_seq    =  intr_seq::type_id::create("int_seq");
		ct_seq     =  ctrl_seq::type_id::create("ct_seq");
		io_seq     =  io_addr_seq::type_id::create("io_seq");
		mem_seq    =  mem_addr_seq::type_id::create("mem_seq");
		info_seq   =  extra_info_seq::type_id::create("info_seq");
  	stat_seq   =  status_seq::type_id::create("stat_seq");
  	trans_seq  =  transfer_count_seq::type_id::create("trans_seq");
		des_seq    =  descriptor_addr_seq::type_id::create("des_seq");
		err_seq    =  error_status_seq::type_id::create("err_seq");
		con_seq    =  configure_seq::type_id::create("con_seq");

		rst_seq.regbk    =  regbk;
		int_seq.regbk    =  regbk;
		ct_seq.regbk     =  regbk;
		io_seq.regbk     =  regbk;
		mem_seq.regbk    =  regbk;
		info_seq.regbk   =  regbk;
  	stat_seq.regbk   =  regbk;
  	trans_seq.regbk  =  regbk;
		des_seq.regbk    =  regbk;
		err_seq.regbk    =  regbk;
		con_seq.regbk    =  regbk;

		rst_seq.start(m_sequencer);
		int_seq.start(m_sequencer);
		ct_seq.start(m_sequencer);
		io_seq.start(m_sequencer);
		mem_seq.start(m_sequencer);
  	info_seq.start(m_sequencer);
  	stat_seq.start(m_sequencer);
  	trans_seq.start(m_sequencer);
		des_seq.start(m_sequencer);
		err_seq.start(m_sequencer);
		con_seq.start(m_sequencer);
	endtask

endclass

