class status_seq extends uvm_sequence;
	`uvm_object_utils(status_seq) 
	dma_reg_block regbk;

	function new (string name = "status_seq"); 
		super.new(name); 
	endfunction 

	task body; 
		uvm_status_e stat; 
		bit [31:0] w_data ,r_data; 
		bit [31:0] temp;
		w_data[0] = $urandom;
		w_data[1] = $urandom;
		w_data[2] = $urandom;
		w_data[3] = $urandom;
		w_data[7:4] = $urandom;
		w_data[15:8] = $urandom;
 
    temp = w_data;

		`uvm_info(get_type_name()," <------------ STATUS SEQUENCE STARTED -----------> \n", UVM_MEDIUM) 	

		`uvm_info(get_type_name(),"Applying reset on status register", UVM_MEDIUM)
	   
		 regbk.reg_file.status.reset(); 

		`uvm_info(get_type_name(), $sformatf(" STATUS[0] = %0d | STATUS[1] = %0d | STATUS[2] = %0d | STATUS[3] = %0d | STATUS[7:4] = %0d | STATUS[15:8] = %0d\n ", r_data[0] , r_data[1] , r_data[2] , r_data[3] , r_data[7:4] , r_data[15:8] ), UVM_MEDIUM) 
	
		`uvm_info(get_type_name(),"performing backdoor write method", UVM_MEDIUM)
	  `uvm_info(get_type_name(), $sformatf(" STATUS[0] = %0d | STATUS[1] = %0d | STATUS[2] = %0d | STATUS[3] = %0d | STATUS[7:4] = %0d | STATUS[15:8] = %0d ", w_data[0] , w_data[1] , w_data[2] , w_data[3] , w_data[7:4] , w_data[15:8] ), UVM_MEDIUM) 
		`uvm_info(get_type_name(),"Writing w_data to the dut STATUS register \n", UVM_MEDIUM) 

		regbk.reg_file.status.poke( stat, w_data ); 

    if (stat != UVM_IS_OK) `uvm_error(get_type_name(), "STATUS register backdoor write failed\n") 
	
		w_data[0] = $urandom;
		w_data[1] = $urandom;
		w_data[2] = $urandom;
		w_data[3] = $urandom;
		w_data[7:4] = $urandom;
		w_data[15:8] = $urandom; 

		`uvm_info(get_type_name(),"performing frontdoor write method", UVM_MEDIUM)
	
		`uvm_info(get_type_name(), $sformatf(" STATUS[0] = %0d | STATUS[1] = %0d | STATUS[2] = %0d | STATUS[3] = %0d | STATUS[7:4] = %0d | STATUS[15:8] = %0d ", w_data[0] , w_data[1] , w_data[2] , w_data[3] , w_data[7:4] , w_data[15:8] ), UVM_MEDIUM) 
		
		`uvm_info(get_type_name(),"Writing w_data to the dut STATUS register \n", UVM_MEDIUM) 
  	
		regbk.reg_file.status.write( stat, w_data );
		if (stat != UVM_IS_OK) `uvm_error(get_type_name(), "STATUS register frontdoor write failed\n") 

   	`uvm_info(get_type_name()," performing backdoor read method ", UVM_MEDIUM) 
 
		regbk.reg_file.status.read( stat, r_data ); 
		`uvm_info(get_type_name(), $sformatf("Read STATUS = %0d\n", r_data), UVM_MEDIUM) 

		if (stat != UVM_IS_OK) `uvm_error(get_type_name(), "STATUS register read failed\n") 

		if ( r_data != temp )
		`uvm_error(get_type_name(), "status_reg mismatch\n") 
		else `uvm_info(get_type_name(),"STATUS register contents passed\n",UVM_NONE)
		`uvm_info(get_type_name(), $sformatf(" STATUS[0] = %0d | STATUS[1] = %0d | STATUS[2] = %0d | STATUS[3] = %0d | STATUS[7:4] = %0d | STATUS[15:8] = %0d\n", r_data[0] , r_data[1] , r_data[2] , r_data[3] , r_data[7:4] , r_data[15:8] ), UVM_MEDIUM) 
	
		`uvm_info(get_type_name()," <------------ STATUS SEQUENCE ENDED ----------->\n ", UVM_MEDIUM) 	

	endtask

endclass

