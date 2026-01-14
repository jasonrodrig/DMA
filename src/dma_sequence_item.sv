class dma_sequence_item extends uvm_sequence_item;

  rand bit reset;
	rand bit wr_en;
	rand bit [ `DATA_WIDTH - 1  :0 ] wdata;
	rand bit [ `ADDR_WIDTH - 1  :0 ] addr;
	     bit [ `DATA_WIDTH - 1 : 0 ] rdata;

	`uvm_object_utils_begin(dma_sequence_item)
	`uvm_field_int(reset,UVM_ALL_ON)
	`uvm_field_int(wr_en,UVM_ALL_ON)
	`uvm_field_int(addr,UVM_ALL_ON)
	`uvm_field_int(wdata,UVM_ALL_ON)
	`uvm_field_int(rdata,UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name = "dma_sequence_item");
		super.new(name);
	endfunction

endclass
