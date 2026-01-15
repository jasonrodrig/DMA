class dma_reg_seq extends uvm_sequence#(dma_sequence_item);
	`uvm_object_utils(dma_reg_seq)
	dma_reg_block regbk;

	function new (string name = "dma_reg_seq");
		super.new(name);
	endfunction

	task body; 
  `uvm_do(req);
	endtask

endclass
