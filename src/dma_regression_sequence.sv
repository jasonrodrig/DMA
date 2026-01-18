
	class dma_regression extends uvm_sequence;
	`uvm_object_utils(dma_regression)
	
  ctrl_seq ct_seq;

	function new (string name = "dma_regression_seq");
		super.new(name);
	endfunction

	task body; 
    `uvm_do(ct_seq)
	endtask

endclass

