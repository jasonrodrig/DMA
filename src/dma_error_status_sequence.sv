class error_status_seq extends uvm_sequence;
	`uvm_object_utils(error_status_seq) 
	dma_reg_block regbk;

	function new (string name = "error_status_seq"); 
		super.new(name); 
	endfunction 

	task body; 
		uvm_status_e status; 
		bit [31:0] w_data ,r_data; 
		//bit [31:0] mirror;

		regbk.reg_file.error_status.write( status, w_data,.parent(this) ); // just to delay reset

		repeat(`N	) begin
		w_data = $urandom();

		`uvm_info(get_type_name()," <------------ ERROR_STATUS SEQUENCE STARTED ----------->\n ", UVM_MEDIUM) 	

		`uvm_info(get_type_name(), $sformatf(" ERROR_STATUS[31:0] = %0d", w_data), UVM_MEDIUM) 
		`uvm_info(get_type_name(), $sformatf("Writing ERROR_STATUS = %0d\n", w_data), UVM_MEDIUM) 
		regbk.reg_file.error_status.write( status, w_data,.parent(this) ); 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "ERROR_STATUS register write failed\n") 
		
		//mirror = regbk.reg_file.error_status.get_mirrored_value(); 
		//`uvm_info(get_type_name(), $sformatf("ERROR_STATUS mirrored = %0d\n", mirror), UVM_MEDIUM)

		regbk.reg_file.error_status.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read ERROR_STATUS = %0d\n", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "ERROR_STATUS register read failed\n") 
		
		if (r_data != 0 ) `uvm_error(get_type_name(), "error_status mismatch\n") 
		else `uvm_info(get_type_name(),"ERROR_STATUS register contents passed\n",UVM_NONE)

		`uvm_info(get_type_name(), $sformatf(" ERROR_STATUS[31:0] = %0d\n" , r_data), UVM_MEDIUM) 
    
		`uvm_info(get_type_name()," <------------ ERROR_STATUS SEQUENCE FINISHED ----------->\n ", UVM_MEDIUM) 	
     
		end
	endtask

endclass

