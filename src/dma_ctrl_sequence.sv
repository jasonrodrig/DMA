class ctrl_seq extends uvm_sequence;
	`uvm_object_utils(ctrl_seq) 
	dma_reg_block regbk;

	function new (string name = "ctrl_seq"); 
		super.new(name); 
	endfunction 

	task body; 
		uvm_status_e status; 
		bit [31:0] w_data ,r_data; 
		bit [31:0] mirror;

		// self clear start_dma check
		 w_data[0] = 1;
		 w_data[15:1] = $urandom;
		 w_data[16] = 0;

		`uvm_info(get_type_name()," <------------ CTRL SEQUENCE STARTED ----------->\n ", UVM_MEDIUM) 	

		`uvm_info(get_type_name(), $sformatf(" CTRL[0] = %0d | CTRL[15:1] = %0d | CTRL[16] = %0d", w_data[0], w_data[15:1] ,w_data[16]), UVM_MEDIUM) 
		`uvm_info(get_type_name(), $sformatf("Writing CTRL = %0d", w_data), UVM_MEDIUM) 
		regbk.reg_file.ctrl.write( status, w_data,.parent(this) ); 

    if (status != UVM_IS_OK) `uvm_error(get_type_name(), "CTRL register write failed\n") 

		mirror = regbk.reg_file.ctrl.get_mirrored_value(); 
		`uvm_info(get_type_name(), $sformatf("CTRL mirrored = %0d\n", mirror), UVM_MEDIUM)

  	`uvm_info(get_type_name(), $sformatf("perform read operation on ist cycle CTRL "), UVM_MEDIUM) 
		
		regbk.reg_file.ctrl.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read CTRL = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "CTRL register read failed\n") 

		if (r_data[0] == 0 && r_data[15:1] == w_data[15:1] && r_data[16] == 0) `uvm_info(get_type_name(),"CTRL register contents passed",UVM_NONE)
    else `uvm_error(get_type_name(), "ctrl_mem mismatch") 

		`uvm_info(get_type_name(), $sformatf(" CTRL[0] = %0d | CTRL[15:1] = %0d | CTRL[16] = %0d\n", r_data[0], r_data[15:1] ,r_data[16]), UVM_MEDIUM) 

		`uvm_info(get_type_name(), $sformatf("perform read operation on 2st cycle CTRL "), UVM_MEDIUM) 
	
		regbk.reg_file.ctrl.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read CTRL = %0d", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "CTRL register read failed") 

		if (r_data[0] == 0 && r_data[15:1] == w_data[15:1] && r_data[16] == 0) `uvm_info(get_type_name(),"CTRL register contents passed",UVM_NONE)
    else `uvm_error(get_type_name(), "ctrl_mem mismatch") 

		`uvm_info(get_type_name(), $sformatf(" CTRL[0] = %0d | CTRL[15:1] = %0d | CTRL[16] = %0d\n", r_data[0], r_data[15:1] ,r_data[16]), UVM_MEDIUM) 
		`uvm_info(get_type_name()," <------------ CTRL SEQUENCE ENDED ----------->\n ", UVM_MEDIUM) 	


	endtask

endclass

