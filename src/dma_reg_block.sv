class dma_reg_block extends uvm_reg_block;
	`uvm_object_utils(dma_reg_block)
	dma_reg_file reg_file;

	function new (string name = "dma_reg_block");
		super.new(name, UVM_NO_COVERAGE);
	endfunction

	function void build();
		add_hdl_path("dut","RTL");
		uvm_reg::include_coverage("*", UVM_CVR_FIELD_VALS);
		default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN,1); 
		reg_file    = dma_reg_file::type_id::create("reg_file");

		reg_file.build();
		reg_file.configure(this,null);
		//reg_file.set_coverage(UVM_CVR_FIELD_VALS); 
		reg_file.intr.configure(this);
		reg_file.ctrl.configure(this);
		reg_file.io_addr.configure(this);
		reg_file.mem_addr.configure(this);
		reg_file.extra_info.configure(this);
		reg_file.status.configure(this);
		reg_file.transfer_count.configure(this);
		reg_file.descriptor_addr.configure(this);
  	reg_file.error_status.configure(this);
		reg_file.configuration.configure(this);
   
		reg_file.intr.add_hdl_path_slice("intr_status" , 0 , 16);
   	reg_file.intr.add_hdl_path_slice("intr_mask" , 0 , 16);

//  	reg_file.ctrl.add_hdl_path_slice(" " , 0 , 32);
//  	reg_file.io_addr.add_hdl_path_slice(" " , 0 , 32);
//  	reg_file.mem_addr.add_hdl_path_slice(" " , 0 , 32);
//  	reg_file.extra_info.add_hdl_path_slice(" " , 0 , 32);
//  	reg_file.status.add_hdl_path_slice(" " , 0 , 32);
//  	reg_file.transfer_count.add_hdl_path_slice(" " , 0 , 32);
//  	reg_file.descriptor_addr.add_hdl_path_slice(" " , 0 , 32);
//   	reg_file.error_status.add_hdl_path_slice(" " , 0 , 32);
//  	reg_file.configuration.add_hdl_path_slice(" " , 0 , 32);

		default_map.add_reg(reg_file.intr,            'h400, "RO");
		default_map.add_reg(reg_file.ctrl,            'h404, "RW");
		default_map.add_reg(reg_file.io_addr,         'h408, "RW");
		default_map.add_reg(reg_file.mem_addr,        'h40C, "RW");
		default_map.add_reg(reg_file.extra_info,      'h410, "RW");
		default_map.add_reg(reg_file.status,          'h414, "RO");
		default_map.add_reg(reg_file.transfer_count,  'h418, "RO");
		default_map.add_reg(reg_file.descriptor_addr, 'h41C, "RW");
		default_map.add_reg(reg_file.error_status,    'h420, "RW");
		default_map.add_reg(reg_file.configuration,   'h424, "RW");

		lock_model();
	endfunction

endclass
