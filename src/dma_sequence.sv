class dma_seq extends uvm_sequence#(dma_sequence_item);
	`uvm_object_utils(dma_seq)

	function new (string name = "dma_seq");
		super.new(name);
	endfunction
  
 `uvm_declare_p_sequencer(dma_sequencer)

	task body; 
   repeat(2) begin
     req = dma_sequence_item::type_id::create("req");
		 wait_for_grant();
		 req.randomize();
		 send_request(req);
		 wait_for_item_done();
	 end 
	endtask

endclass

class write_seq extends uvm_sequence#(dma_sequence_item);
	`uvm_object_utils(write_seq)

	function new(string name = "write_sequence");
		super.new(name);
	endfunction

  task body();
		`uvm_do_with(req,{req.wr_en==1; req.rd_en == 0;})
	endtask
endclass

class read_seq extends uvm_sequence#(dma_sequence_item);
	`uvm_object_utils(read_seq)

	function new(string name = "read_sequence");
		super.new(name);
	endfunction

	task body();
		`uvm_do_with(req,{req.rd_en == 1; req.wr_en == 0;})
	endtask
endclass
