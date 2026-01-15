class dma_intr_reg extends uvm_reg;

	`uvm_object_utils(dma_intr_reg)
	rand uvm_reg_field intr_status;
	rand uvm_reg_field intr_mask;	

	covergroup intr_reg_cvgrp;

		option.per_instance = 1;

		coverpoint intr_status.value[7:0]
		{
			bins lower_intr_status1 = {[0:63]};
			bins mid_intr_status1   = {[64:127]};
			bins high_intr_status1  = {[128:255]};
		}

		coverpoint intr_status.value[15:8]
		{
			bins lower_intr_status2 = {[0:63]};
			bins mid_intr_status2   = {[64:127]};
			bins high_intr_status2  = {[128:255]};
		}

		coverpoint intr_mask.value[23:16]
		{
			bins lower_intr_mask1 = {[0:63]};
			bins mid_intr_mask1   = {[64:127]};
			bins high_intr_mask1  = {[128:255]};
		}

		coverpoint intr_mask.value[31:24]
		{
			bins lower_intr_mask2 = {[0:63]};
			bins mid_intr_mask2   = {[64:127]};
			bins high_intr_mask2  = {[128:255]};
		}

	endgroup

	function new ( string name = "dma_intr_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
			intr_reg_cvgrp = new();
	endfunction

	function void sample(
		uvm_reg_data_t data,
		uvm_reg_data_t byte_en,
		bit is_read,
		uvm_reg_map map
	);
		intr_reg_cvgrp.sample();
	endfunction

	function void sample_values();
		super.sample_values();
		intr_reg_cvgrp.sample();
	endfunction

	function void build();

		intr_status = uvm_reg_field::type_id::create("intr_status");
		intr_mask   = uvm_reg_field::type_id::create("intr_mask");

		intr_status.configure( 
			.parent(this),
			.size(16),
			.lsb_pos(0),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

		intr_mask.configure( 
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
