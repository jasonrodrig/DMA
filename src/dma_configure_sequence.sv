class configure_seq extends uvm_sequence;
	`uvm_object_utils(configure_seq) 
	dma_reg_block regbk;

	function new (string name = "configure_seq"); 
		super.new(name); 
	endfunction 

	task body; 
		uvm_status_e status; 
		bit [31:0] w_data ,r_data; 
		bit [31:0] mirror;
		w_data[1:0] = 2; 
		w_data[2] = 0;  
		w_data[3] = 1; 
    w_data[5:4] = 3; 
   	w_data[7:6] = 1; 
		w_data[8] = 1; 

		`uvm_info(get_type_name()," <------------ CONFIGURE SEQUENCE STARTED ----------->\n ", UVM_MEDIUM) 	

		`uvm_info(get_type_name(), $sformatf("CONFIG[1:0] = %0d | CONFIG[2] = %0d | CONFIG[3] = %0d | CONFIG[5:4] = %0d | CONFIG[7:6] = %0d | CONFIG[8] = %0d", w_data[1:0] , w_data[2] , w_data[3] , w_data[5:4] , w_data[7:6] , w_data[8] ), UVM_MEDIUM) 
		`uvm_info(get_type_name(), $sformatf("Writing CONFIGURE = %0d\n", w_data), UVM_MEDIUM) 
		regbk.reg_file.configuration.write( status, w_data,.parent(this) ); 

    if (status != UVM_IS_OK) `uvm_error(get_type_name(), "CONFIGURE register write failed\n") 

		mirror = regbk.reg_file.configuration.get_mirrored_value(); 
		`uvm_info(get_type_name(), $sformatf("CONFIGURE mirrored = %0d\n", mirror), UVM_MEDIUM)

		regbk.reg_file.configuration.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read CONFIGURE = %0d\n", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "CONFIGURE register read failed\n") 

		if ( r_data[1:0] != 2 && r_data[2] != 0 && r_data[3] != 1 && r_data[5:4] != 3 && r_data[7:6] != 1 && r_data[8] != 1  ) 
			`uvm_error(get_type_name(), "configure_mem mismatch\n") 
		
		else `uvm_info(get_type_name(),"CONFIGURE register contents passed",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf("CONFIG[1:0] = %0d | CONFIG[2] = %0d | CONFIG[3] = %0d | CONFIG[5:4] = %0d | CONFIG[7:6] = %0d | CONFIG[8] = %0d\n", r_data[1:0] , r_data[2] , r_data[3] , r_data[5:4] , r_data[7:6] , r_data[8] ), UVM_MEDIUM) 

		`uvm_info(get_type_name()," <------------ CONFIGURE SEQUENCE ENDED ----------->\n ", UVM_MEDIUM) 	

	endtask

endclass

