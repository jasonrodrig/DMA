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
		w_data[0] = 1; 
		w_data[15:1] = 15'd16; 
		w_data[16] = 1; 

		`uvm_info(get_type_name(), $sformatf("Writing CTRL = 0x%08h", w_data), UVM_MEDIUM) 
		regbk.reg_file.ctrl.write( status, w_data,.parent(this) ); 

		if (status != UVM_IS_OK) 
			`uvm_error("RAL_SEQ", "CTRL register write failed") 

			mirror = regbk.reg_file.ctrl.get_mirrored_value(); 
		`uvm_info("CTRL_SEQ", $sformatf("CTRL mirrored = 0x%08h", mirror), UVM_MEDIUM)

		regbk.reg_file.ctrl.read( status, r_data,.parent(this) ); 
		`uvm_info(get_type_name(), $sformatf("Read CTRL = 0x%08h", r_data), UVM_MEDIUM) 

		if (status != UVM_IS_OK) `uvm_error("RAL_SEQ", "CTRL register read failed") 
		if (r_data[15:1] != 15'd16) `uvm_error("RAL_SEQ", "w_count mismatch")
		if (r_data[16] != 1'b1) `uvm_error("RAL_SEQ", "io_mem mismatch") 
					// start_dma is self-clearing → expected 0
		if (r_data[0] != 1'b1) `uvm_error("RAL_SEQ", "start_dma not cleared yet") 
	endtask

endclass

