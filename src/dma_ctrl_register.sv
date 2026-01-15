class dma_ctrl_reg extends uvm_reg;

	`uvm_object_utils(dma_ctrl_reg)
	rand uvm_reg_field start_dma;
	rand uvm_reg_field w_count;
	rand uvm_reg_field io_mem;
	uvm_reg_field reserved;

	covergroup ctrl_reg_cvgrp;

		option.per_instance = 1;

		coverpoint start_dma.value[0]
		{
			bins start_dma_val = {0,1};
		}

		coverpoint w_count.value[7:1]
		{
			bins lower_w_count1 = {[0:63]};
			bins mid_w_count1   = {[64:127]};
			//bins high_w_count1  = {[128:255]};
		}

		coverpoint w_count.value[15:8]
		{
			bins lower_w_count2 = {[0:63]};
			bins mid_w_count2   = {[64:127]};
			bins high_w_count2  = {[128:255]};
		}

		coverpoint io_mem.value[16]
		{
			bins io_mem_val = {0,1};
		}

	endgroup

	function new ( string name = "dma_ctrl_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
			ctrl_reg_cvgrp = new();
	endfunction

	function void sample(
		uvm_reg_data_t data,
		uvm_reg_data_t byte_en,
		bit is_read,
		uvm_reg_map map
	);
		ctrl_reg_cvgrp.sample();
	endfunction

	function void sample_values();
		super.sample_values();
		ctrl_reg_cvgrp.sample();
	endfunction

	function void build();

		start_dma = uvm_reg_field::type_id::create("start_dma");
		w_count   = uvm_reg_field::type_id::create("w_count");
		io_mem    = uvm_reg_field::type_id::create("io_mem");
		reserved  = uvm_reg_field::type_id::create("reserved");

		start_dma.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(0),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		w_count.configure( 
			.parent(this),
			.size(15),
			.lsb_pos(1),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		io_mem.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(16),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		reserved.configure( 
			.parent(this),
			.size(15),
			.lsb_pos(17),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

	endfunction

endclass
