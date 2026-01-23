class dma_reg_block extends uvm_reg_block;
	`uvm_object_utils(dma_reg_block)
	dma_reg_file reg_file;

	function new (string name = "dma_reg_block");
		super.new(name, UVM_NO_COVERAGE);
	endfunction

	function void build();
	 // add_hdl_path("top.DUT","RTL");
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
    reg_file.intr.add_hdl_path_slice("intr_mask" , 16 , 16);

		reg_file.ctrl.add_hdl_path_slice("ctrl_start_dma" , 0 , 1);
 	  reg_file.ctrl.add_hdl_path_slice("ctrl_w_count" , 1 , 15);
  	reg_file.ctrl.add_hdl_path_slice("ctrl_io_mem" , 16 , 1);
    
		reg_file.io_addr.add_hdl_path_slice("io_addr" , 0 , 32);  
		
		reg_file.mem_addr.add_hdl_path_slice("mem_addr " , 0 , 32); 
		
		reg_file.extra_info.add_hdl_path_slice("extra_info " , 0 , 32);
    
		reg_file.status.add_hdl_path_slice("status_busy" , 0 , 1);
    reg_file.status.add_hdl_path_slice("status_done" , 1 , 1);
    reg_file.status.add_hdl_path_slice("status_error" , 2 , 1);
    reg_file.status.add_hdl_path_slice("status_paused" , 3 , 1); 
		reg_file.status.add_hdl_path_slice("status_current_state" , 4 , 4);
    reg_file.status.add_hdl_path_slice("status_fifo_level" , 8 , 8);

		reg_file.transfer_count.add_hdl_path_slice("transfer_count" , 0 , 32);

    reg_file.descriptor_addr.add_hdl_path_slice("descriptor_addr" , 0 , 32);
   
		reg_file.error_status.add_hdl_path_slice("error_bus" , 0 , 1);
		reg_file.error_status.add_hdl_path_slice("error_timeout" , 1 , 1);
    reg_file.error_status.add_hdl_path_slice("error_alignment" , 2 , 1);
    reg_file.error_status.add_hdl_path_slice("error_overflow" , 3 , 1); 
		reg_file.error_status.add_hdl_path_slice("error_underflow" , 4 , 1);
    reg_file.error_status.add_hdl_path_slice("error_code" , 8 , 8);
    reg_file.error_status.add_hdl_path_slice("error_addr_offset" , 16 , 16);

  	reg_file.configuration.add_hdl_path_slice("config_priority" , 0 , 2);
    reg_file.configuration.add_hdl_path_slice("config_auto_restart" , 2 , 1);
    reg_file.configuration.add_hdl_path_slice("config_interrupt_enable " , 3 , 1);
   	reg_file.configuration.add_hdl_path_slice("config_burst_size" , 4 , 2);
    reg_file.configuration.add_hdl_path_slice("config_data_width" , 6 , 2);
    reg_file.configuration.add_hdl_path_slice("config_descriptor_mode " , 8 , 1);

		default_map.add_reg(reg_file.intr,            'h400, "RW");
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
