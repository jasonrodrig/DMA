class dma_transfer_count_reg extends uvm_reg;

	`uvm_object_utils(dma_transfer_count_reg)
	rand uvm_reg_field transfer_count;

	covergroup transfer_count_reg_cvgrp;

		option.per_instance = 1;

		coverpoint transfer_count.value[7:0]
		{
			bins lower_transfer_count1 = {[0:63]};
			bins mid_transfer_count1   = {[64:127]};
			bins high_transfer_count1  = {[128:255]};
		}

		coverpoint transfer_count.value[15:8]
		{
			bins lower_transfer_count2 = {[0:63]};
			bins mid_transfer_count2   = {[64:127]};
			bins high_transfer_count2  = {[128:255]};
		}

		coverpoint transfer_count.value[23:16]
		{
			bins lower_transfer_count3 = {[0:63]};
			bins mid_transfer_count3   = {[64:127]};
			bins high_transfer_count3  = {[128:255]};
		}

		coverpoint transfer_count.value[31:24]
		{
			bins lower_transfer_count4 = {[0:63]};
			bins mid_transfer_count4   = {[64:127]};
			bins high_transfer_count4  = {[128:255]};
		}

	endgroup

	function new ( string name = "dma_transfer_count_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
			transfer_count_reg_cvgrp = new();
	endfunction

	function void sample(
		uvm_reg_data_t data,
		uvm_reg_data_t byte_en,
		bit is_read,
		uvm_reg_map map
	);
		transfer_count_reg_cvgrp.sample();
	endfunction

	function void sample_values();
		super.sample_values();
		transfer_count_reg_cvgrp.sample();
	endfunction

	function void build();

		transfer_count = uvm_reg_field::type_id::create("transfer_count");

		transfer_count.configure( 
			.parent(this),
			.size(32),
			.lsb_pos(0),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

	endfunction

endclass
