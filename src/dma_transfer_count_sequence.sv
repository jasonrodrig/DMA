class transfer_count_seq extends uvm_sequence;
	`uvm_object_utils(transfer_count_seq) 
	dma_reg_block regbk;

	function new (string name = "transfer_count_seq"); 
		super.new(name); 
	endfunction 

	task body; 
		uvm_status_e status; 
		bit [31:0] w_data , r_data, temp ; 
		
		w_data = $urandom;  
    temp = w_data;
		`uvm_info(get_type_name()," <------------ TRANSFER_COUNT SEQUENCE STARTED -----------> \n", UVM_MEDIUM) 	

    `uvm_info(get_type_name(),"Applying reset on TRANSFER_COUNT register", UVM_MEDIUM)
	   
		 regbk.reg_file.transfer_count.reset(); 

    `uvm_info(get_type_name(), $sformatf(" TRANSFER_COUNT[31:0] = %0d", r_data ), UVM_MEDIUM) 
	
  	`uvm_info(get_type_name(),"performing backdoor write method", UVM_MEDIUM)
	  `uvm_info(get_type_name(), $sformatf(" TRANSFER_COUNT[31:0] = %0h ", w_data ), UVM_MEDIUM) 
		`uvm_info(get_type_name(),"Writing w_data to the dut TRANSFER_COUNT register \n", UVM_MEDIUM) 

		regbk.reg_file.transfer_count.poke( status, w_data);// ,UVM_BACKDOOR ); 
		//regbk.reg_file.transfer_count.read( status, r_data, UVM_BACKDOOR ); 
		//`uvm_info(get_type_name(), $sformatf("Read TRANSFER_COUNT = %0h\n", r_data), UVM_MEDIUM) 

    if (status != UVM_IS_OK) `uvm_error(get_type_name(), "TRANSFER_COUNT register backdoor write failed\n") 

		 w_data = $urandom ;	
		`uvm_info(get_type_name(),"performing frontdoor write method", UVM_MEDIUM)
		`uvm_info(get_type_name(), $sformatf(" TRANSFER_COUNT[31:0] = %0h ", w_data ), UVM_MEDIUM) 
		`uvm_info(get_type_name(),"Writing w_data to the dut TRANSFER_COUNT register \n", UVM_MEDIUM) 
  	
		regbk.reg_file.transfer_count.write( status, w_data, .parent(this) );
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "TRANSFER_COUNT register frontdoor write failed\n") 

   	`uvm_info(get_type_name()," performing frontdoor read method ", UVM_MEDIUM) 
 
		regbk.reg_file.transfer_count.peek( status, r_data);// UVM_BACKDOOR ); 
		`uvm_info(get_type_name(), $sformatf("Read TRANSFER_COUNT = %0h\n", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "TRANSFER_COUNT register read failed\n") 

		if (r_data != temp ) `uvm_error(get_type_name(), "trasnfer_count_reg mismatch\n") 
		else `uvm_info(get_type_name(),"TRANSFER_COUNT register contents passed\n",UVM_NONE)

		`uvm_info( get_type_name(), $sformatf( "TRANSFER_COUNT[31:0] = %0h \n", r_data ), UVM_MEDIUM)

		`uvm_info(get_type_name()," <------------ TRANSFER_COUNT SEQUENCE ENDED ----------->\n ", UVM_MEDIUM) 	

	endtask

endclass

