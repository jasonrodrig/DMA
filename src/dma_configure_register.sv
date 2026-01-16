class dma_configure_reg extends uvm_reg;

	`uvm_object_utils(dma_configure_reg)
	rand uvm_reg_field prioritye;
	rand uvm_reg_field auto_restart;
	rand uvm_reg_field interrupt_enable;
	rand uvm_reg_field burst_size;
	rand uvm_reg_field data_width;
	rand uvm_reg_field descriptor_mode;
	uvm_reg_field reserved;

	covergroup configure_reg_cvgrp;

		option.per_instance = 1;

		coverpoint prioritye.value[1:0]
		{
			bins prioritye_val = {0,1,2,3};
		}

		coverpoint auto_restart.value[2]
		{
			bins auto_restart = {0,1};
		}

		coverpoint interrupt_enable.value[3]
		{
			bins interrupt_enable_val = {0,1};
		}

		coverpoint burst_size.value[5:4]
		{
			bins burst_size_val = {0,1,2,3};
		}

		coverpoint data_width.value[7:6]
		{
			bins data_width_val = {0,1,2,3};
		}

		coverpoint descriptor_mode.value[8]
		{
			bins decriptor_mode_val = {0,1};
		}

	endgroup

	function new ( string name = "dma_configure_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
			configure_reg_cvgrp = new();
	endfunction

	function void sample(
		uvm_reg_data_t data,
		uvm_reg_data_t byte_en,
		bit is_read,
		uvm_reg_map map
	);
		configure_reg_cvgrp.sample();
	endfunction

	function void sample_values();
		super.sample_values();
		configure_reg_cvgrp.sample();
	endfunction

	function void build();

		prioritye           = uvm_reg_field::type_id::create("prioritye");
		auto_restart        = uvm_reg_field::type_id::create("auto_restart");
		interrupt_enable    = uvm_reg_field::type_id::create("interrupt_enable");
		burst_size          = uvm_reg_field::type_id::create("burst_size");
		data_width          = uvm_reg_field::type_id::create("data_width");
		descriptor_mode     = uvm_reg_field::type_id::create("descriptor_mode");
		reserved            = uvm_reg_field::type_id::create("reserved");

		prioritye.configure( 
			.parent(this),
			.size(2),
			.lsb_pos(0),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		auto_restart.configure( 
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

		interrupt_enable.configure( 
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

		burst_size.configure( 
			.parent(this),
			.size(2),
			.lsb_pos(4),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		data_width.configure( 
			.parent(this),
			.size(2),
			.lsb_pos(6),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		descriptor_mode.configure( 
			.parent(this),
			.size(1),
			.lsb_pos(8),
			.access("RW"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(1),
			.individually_accessible(1)
		);

		reserved.configure( 
			.parent(this),
			.size(23),
			.lsb_pos(9),
			.access("RO"),
			.volatile(0),
			.reset('h0),
			.has_reset(1),
			.is_rand(0),
			.individually_accessible(1)
		);

	endfunction

endclass
