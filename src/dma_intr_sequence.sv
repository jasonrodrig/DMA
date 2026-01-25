class intr_seq extends uvm_sequence;
	`uvm_object_utils(intr_seq) 
	dma_reg_block regbk;

	function new (string name = "intr_seq"); 
		super.new(name); 
	endfunction 

	task body; 
		uvm_status_e status; 
		bit [31:0] w_data ,r_data; 
		bit [15:0] partion1 , partion2;
		bit [31:0] temp; 

		regbk.reg_file.intr.write( status, w_data,.parent(this) );// just to delay for the reset at start; 
	
		repeat (`N) begin
		w_data[15:0] = $urandom; 
		w_data[31:16] = $urandom_range( 256,65535); 
		partion1 = w_data[15:0];

		`uvm_info(get_type_name()," <------------ INTR SEQUENCE STARTED -----------> \n", UVM_MEDIUM) 	

		`uvm_info(get_type_name(),"performing backdoor write method", UVM_MEDIUM)
		`uvm_info(get_type_name(), $sformatf(" INTR[15:0] = %0d | INTR[31:16] = %0d ", w_data[15:0], w_data[31:16] ), UVM_MEDIUM) 
		`uvm_info(get_type_name(),"Writing w_data to the dut INTR register \n", UVM_MEDIUM) 

		regbk.reg_file.intr.poke( status, w_data,.parent(this) ); 

    if (status != UVM_IS_OK) `uvm_error(get_type_name(), "INTR register backdoor write failed\n") 

		w_data[15:0]  = $urandom;
		w_data[31:16] = $urandom_range(64,65535);
		partion2 = w_data[31:16];

		`uvm_info(get_type_name(),"performing frontdoor write method", UVM_MEDIUM)
		`uvm_info(get_type_name(), $sformatf(" INTR[15:0] = %0d | INTR[31:16] = %0d ", w_data[15:0], w_data[31:16] ), UVM_MEDIUM) 
		`uvm_info(get_type_name(),"Writing w_data to the dut INTR register \n", UVM_MEDIUM) 
  	
		regbk.reg_file.intr.write( status, w_data,.parent(this) );
		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "INTR register frontdoor write failed\n") 

   	`uvm_info(get_type_name()," performing frontdoor read method ", UVM_MEDIUM) 
 
		regbk.reg_file.intr.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read INTR = %0d\n", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error(get_type_name(), "INTR register read failed\n") 
    
		temp = { partion2 , partion1 };
   // `uvm_info( get_type_name(), $sformatf( "partion1 = %0d | partion2 = %0d | temp = %0d \n", partion1, partion2 , temp ), UVM_MEDIUM)

		if (r_data != temp ) `uvm_error(get_type_name(), "intr_reg mismatch\n") 
		else `uvm_info(get_type_name(),"INTR register contents passed\n",UVM_NONE)

		`uvm_info( get_type_name(), $sformatf( "INTR[15:0] = %0d | INTR[31:16] = %0d\n", r_data[15:0], r_data[31:16] ), UVM_MEDIUM)

		`uvm_info(get_type_name()," <------------ INTR SEQUENCE ENDED ----------->\n ", UVM_MEDIUM) 	
    
		end
	endtask

endclass

