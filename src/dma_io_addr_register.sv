class dma_io_addr_reg extends uvm_reg;

	`uvm_object_utils(dma_io_addr_reg)
	rand uvm_reg_field io_addr;

	covergroup io_addr_reg_cvgrp;

		option.per_instance = 1;

		coverpoint io_addr.value[7:0]
		{
			bins lower_io_addr1 = {[0:63]};
			bins mid_io_addr1   = {[64:127]};
			bins high_io_addr1  = {[128:255]};
		}

		coverpoint io_addr.value[15:8]
		{
			bins lower_io_addr2 = {[0:63]};
			bins mid_io_addr2   = {[64:127]};
			bins high_io_addr2  = {[128:255]};
		}

		coverpoint io_addr.value[23:16]
		{
			bins lower_io_addr3 = {[0:63]};
			bins mid_io_addr3   = {[64:127]};
			bins high_io_addr3  = {[128:255]};
		}

		coverpoint io_addr.value[31:24]
		{
			bins lower_io_addr4 = {[0:63]};
			bins mid_io_addr4   = {[64:127]};
			bins high_io_addr4  = {[128:255]};
		}

	endgroup

	function new ( string name = "dma_io_addr_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
			io_addr_reg_cvgrp = new();
	endfunction

	function void sample(
		uvm_reg_data_t data,
		uvm_reg_data_t byte_en,
		bit is_read,
		uvm_reg_map map
	);
		io_addr_reg_cvgrp.sample();
	endfunction

	function void sample_values();
		super.sample_values();
		io_addr_reg_cvgrp.sample();
	endfunction

	function void build();

		io_addr = uvm_reg_field::type_id::create("io_addr");

		io_addr.configure( 
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
