class dma_error_status_reg extends uvm_reg;

	`uvm_object_utils(dma_error_status_reg)
	rand uvm_reg_field bus_error;
	rand uvm_reg_field timeout_error;
	rand uvm_reg_field alignment_error;
	rand uvm_reg_field overflow_error;
	rand uvm_reg_field underflow_error;
	rand uvm_reg_field error_code;
	rand uvm_reg_field error_addr_offset;
	     uvm_reg_field reserved;

	covergroup error_status_reg_cvgrp;

		option.per_instance = 1;

		coverpoint bus_error.value[0]
		{
			bins bus_error_val = {0,1};
		}

		coverpoint timeout_error.value[1]
		{
			bins timeout_error_val = {0,1};
		}

		coverpoint alignment_error.value[2]
		{
			bins alignment_error_val = {0,1};
		}

		coverpoint overflow_error.value[3]
		{
			bins overflow_error_val = {0,1};
		}

		coverpoint underflow_error.value[4]
		{
			bins underflow_error_val = {0,1};
		}

		coverpoint error_code.value[15:8]
		{
			bins lower_error_code = {[0:63]};
			bins mid_error_code   = {[64:127]};
			bins high_error_code  = {[128:255]};
		}
	
		coverpoint error_addr_offset.value[23:16]
		{
			bins lower_error_offset1 = {[0:63]};
			bins mid_error_code_offset1   = {[64:127]};
			bins high_error_code_offset1  = {[128:255]};
		}

    coverpoint error_addr_offset.value[31:24]
		{
			bins lower_error_code_offset2 = {[0:63]};
			bins mid_error_code_offset2   = {[64:127]};
			bins high_error_code_offset2  = {[128:255]};
		}

	endgroup

	function new ( string name = "dma_error_status_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
			error_status_reg_cvgrp = new();
	endfunction

	function void sample(
		uvm_reg_data_t data,
		uvm_reg_data_t byte_en,
		bit is_read,
		uvm_reg_map map
	);
		error_status_reg_cvgrp.sample();
	endfunction

	function void sample_values();
		super.sample_values();
		error_status_reg_cvgrp.sample();
	endfunction

	function void build();

		bus_error          = uvm_reg_field::type_id::create("bus_error");
		timeout_error      = uvm_reg_field::type_id::create("timeout_error");
		alignment_error    = uvm_reg_field::type_id::create("alignment_error");
	  overflow_error     = uvm_reg_field::type_id::create("overflow_errror");
		underflow_error    = uvm_reg_field::type_id::create("underflow_error");
		error_code         = uvm_reg_field::type_id::create("error_code");
  	error_addr_offset  = uvm_reg_field::type_id::create("error_addr_offset");
		reserved           = uvm_reg_field::type_id::create("reserved");

		bus_error.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(0),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

		timeout_error.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(1),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		alignment_error.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(2),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		overflow_error.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(3),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		underflow_error.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(4),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		reserved.configure( 
			.parent(this),
			.size(3),
			.lsb_pos(5),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

		error_code.configure( 
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

		error_addr_offset.configure( 
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
