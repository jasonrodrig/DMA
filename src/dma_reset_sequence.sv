class reset_seq extends uvm_sequence;
	`uvm_object_utils(reset_seq) 
	dma_reg_block regbk;

	function new (string name = "reset_seq"); 
		super.new(name); 
	endfunction 

	task body; 
		uvm_status_e status; 
		bit [31:0] r_data; 
		bit [31:0] rst_value;

		//INTR REGISTER RESET
		`uvm_info(get_type_name()," <------------ RESET SEQUENCE STARTED ----------->\n ", UVM_MEDIUM) 	

		rst_value = regbk.reg_file.intr.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for INTR VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR INTR register failed") 

		regbk.reg_file.intr.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read INTR VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "INTR register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "INTR mismatch") 
		else `uvm_info(get_type_name(),"INTR register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" INTR[31:0] = %0d\n" , r_data), UVM_MEDIUM) 

		//CTRL REGISTER RESET
	
		rst_value = regbk.reg_file.ctrl.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for CTRL VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR CTRL register failed") 

		regbk.reg_file.ctrl.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read CTRL VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "CTRL register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "CTRL mismatch") 
		else `uvm_info(get_type_name(),"CTRL register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" CTRL[31:0] = %0d\n" , r_data), UVM_MEDIUM) 

   // IO_ADDR RESET

	  rst_value = regbk.reg_file.io_addr.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for IO_ADDR VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR IO_ADDR register failed") 

		regbk.reg_file.io_addr.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read IO_ADDR VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "IO_ADDR register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "IO_ADDR mismatch") 
		else `uvm_info(get_type_name(),"IO_ADDR register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" IO_ADDR[31:0] = %0d\n" , r_data), UVM_MEDIUM) 

   // MEM_ADDR RESET
	
    rst_value = regbk.reg_file.mem_addr.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for MEM_ADDR VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR MEM_ADDR register failed") 

		regbk.reg_file.mem_addr.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read MEM_ADDR VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "MEM_ADDR register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "MEM_ADDR mismatch") 
		else `uvm_info(get_type_name(),"MEM_ADDR register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" MEM_ADDR[31:0] = %0d\n" , r_data), UVM_MEDIUM) 

		// EXTRA_INFO RESET
		
    rst_value = regbk.reg_file.extra_info.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for EXTRA_INFO VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR EXTRA_INFO register failed") 

		regbk.reg_file.extra_info.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read EXTRA_INFO VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "EXTRA_INFO register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "EXTRA_INFO mismatch") 
		else `uvm_info(get_type_name(),"EXTRA_INFO register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" EXTRA_INFO[31:0] = %0d\n" , r_data), UVM_MEDIUM) 

    //STATUS RESET

		rst_value = regbk.reg_file.status.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for STATUS VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR STATUS register failed") 

		regbk.reg_file.status.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read STATUS VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "STATUS register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "STATUS mismatch") 
		else `uvm_info(get_type_name(),"STATUS register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" STATUS[31:0] = %0d\n" , r_data), UVM_MEDIUM) 

		//TRANSFER_COUNT RESET

    rst_value = regbk.reg_file.transfer_count.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for TRANSFER_COUNT VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR TRANSFER_COUNT register failed") 

		regbk.reg_file.transfer_count.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read TRANSFER_COUNT VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "TRANSFER_COUNT register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "TRANSFER_COUNT mismatch") 
		else `uvm_info(get_type_name(),"TRANSFER_COUNT register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" TRANSFER_COUNT[31:0] = %0d\n" , r_data), UVM_MEDIUM) 

    // DESCRIPTOR_ADDR RESET
  
		rst_value = regbk.reg_file.descriptor_addr.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for DESCRIPTOR_ADDR VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR DESCRIPTOR_ADDR register failed") 

		regbk.reg_file.descriptor_addr.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read DESCRIPTOR_ADDR VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "DESCRIPTOR_ADDR register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "DESCRIPTOR_ADDR mismatch") 
		else `uvm_info(get_type_name(),"DESCRIPTOR_ADDR register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" DESCRIPTOR_ADDR[31:0] = %0d\n" , r_data), UVM_MEDIUM) 

    // ERROR_STATUS RESET

		rst_value = regbk.reg_file.error_status.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for ERROR_STATUS VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR ERROR_STATUS register failed") 

		regbk.reg_file.error_status.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read ERROR_STATUS VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "ERROR_STATUS register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "ERROR_STATUS mismatch") 
		else `uvm_info(get_type_name(),"ERROR_STATUS register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" ERROR_STATUS[31:0] = %0d\n" , r_data), UVM_MEDIUM) 
  
		//CONFIGURATION RESET

		rst_value = regbk.reg_file.configuration.get_reset( ); 
	 `uvm_info(get_type_name(), $sformatf("RESET for CONFIG VALUE = %0d", rst_value), UVM_MEDIUM) 
	
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "RESET FOR CONFIG register failed") 

		regbk.reg_file.configuration.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read CONFIG VALUE = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "CONFIG register read failed") 
		
		if (r_data != rst_value) `uvm_error(get_type_name(), "CONFIG mismatch") 
		else `uvm_info(get_type_name(),"CONFIG register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" CONFIG[31:0] = %0d\n" , r_data), UVM_MEDIUM) 
		
		`uvm_info(get_type_name()," <------------ RESET SEQUENCE ENDED -----------> \n", UVM_MEDIUM) 	


	endtask

endclass

