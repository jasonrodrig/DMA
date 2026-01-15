class dma_status_reg extends uvm_reg;

	`uvm_object_utils(dma_status_reg)
	rand uvm_reg_field busy;
	rand uvm_reg_field done;
	rand uvm_reg_field error;
	rand uvm_reg_field paused;
	rand uvm_reg_field current_state;
	rand uvm_reg_field fifo_level;
	uvm_reg_field reserved;

	covergroup status_reg_cvgrp;

		option.per_instance = 1;

		coverpoint busy.value[0]
		{
			bins busy_val = {0,1};
		}

		coverpoint done.value[1]
		{
			bins done_val = {0,1};
		}

		coverpoint error.value[2]
		{
			bins error_val = {0,1};
		}

		coverpoint paused.value[3]
		{
			bins paused_val = {0,1};
		}

		coverpoint current_state.value[7:4]
		{
			bins current_state_val = {0,1,2,3};
		}

		coverpoint fifo_level.value[15:8]
		{
			bins lower_w_count1 = {[0:63]};
			bins mid_w_count1   = {[64:127]};
			bins high_w_count1  = {[128:255]};
		}

	endgroup

	function new ( string name = "dma_status_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
			status_reg_cvgrp = new();
	endfunction

	function void sample(
		uvm_reg_data_t data,
		uvm_reg_data_t byte_en,
		bit is_read,
		uvm_reg_map map
	);
		status_reg_cvgrp.sample();
	endfunction

	function void sample_values();
		super.sample_values();
		status_reg_cvgrp.sample();
	endfunction

	function void build();

		busy            = uvm_reg_field::type_id::create("busy");
		done            = uvm_reg_field::type_id::create("done");
		error           = uvm_reg_field::type_id::create("error");
		paused          = uvm_reg_field::type_id::create("paused");
		current_state   = uvm_reg_field::type_id::create("current_state");
		fifo_level      = uvm_reg_field::type_id::create("fifo_level");
		reserved        = uvm_reg_field::type_id::create("reserved");

		busy.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(0),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

		done.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(1),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

		error.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(2),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

		paused.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(3),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

		current_state.configure( 
			.parent(this),
			.size(4),
			.lsb_pos(4),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

		fifo_level.configure( 
			.parent(this),
			.size(8),
			.lsb_pos(8),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

		reserved.configure( 
			.parent(this),
			.size(16),
			.lsb_pos(16),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

	endfunction

endclass
