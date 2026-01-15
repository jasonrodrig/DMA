class dma_extra_info_reg extends uvm_reg;

	`uvm_object_utils(dma_extra_info_reg)
	rand uvm_reg_field extra_info;

	covergroup extra_info_reg_cvgrp;

		option.per_instance = 1;

		coverpoint extra_info.value[7:0]
		{
			bins lower_extra_info1 = {[0:63]};
			bins mid_extra_info1   = {[64:127]};
			bins high_extra_info1  = {[128:255]};
		}

		coverpoint extra_info.value[15:8]
		{
			bins lower_extra_info2 = {[0:63]};
			bins mid_extra_info2   = {[64:127]};
			bins high_extra_info2  = {[128:255]};
		}

		coverpoint extra_info.value[23:16]
		{
			bins lower_extra_info3 = {[0:63]};
			bins mid_extra_info3   = {[64:127]};
			bins high_extra_info3  = {[128:255]};
		}

		coverpoint extra_info.value[31:24]
		{
			bins lower_extra_info4 = {[0:63]};
			bins mid_extra_info4   = {[64:127]};
			bins high_extra_info4  = {[128:255]};
		}

	endgroup

	function new ( string name = "dma_extra_info_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
			extra_info_reg_cvgrp = new();
	endfunction

	function void sample(
		uvm_reg_data_t data,
		uvm_reg_data_t byte_en,
		bit is_read,
		uvm_reg_map map
	);
		extra_info_reg_cvgrp.sample();
	endfunction

	function void sample_values();
		super.sample_values();
		extra_info_reg_cvgrp.sample();
	endfunction

	function void build();

		extra_info = uvm_reg_field::type_id::create("extra_info");

		extra_info.configure( 
			.parent(this),
			.size(32),
			.lsb_pos(0),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

	endfunction

endclass
