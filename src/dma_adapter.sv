class dma_adapter extends uvm_reg_adapter;

	`uvm_object_utils (dma_adapter)
	function new(string name = "dma_adapter");
		super.new(name);
	endfunction

	function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
		dma_sequence_item seq;
		seq = dma_sequence_item::type_id::create("seq");
		if( rw.kind == UVM_WRITE ) 
		begin
			seq.wr_en = 1 ;
		  seq.rd_en = 0 ;
		end
		else begin
			seq.rd_en = 1 ;
			seq.wr_en = 0 ;
		end

		seq.addr = rw.addr;
		if( seq.wr_en ) seq.wdata = rw.data;

		//$display("wr_En = %b, rd_En = %B, addr = %d, data  = %d", seq.wr_en, seq.rd_en, rw.addr, rw.data );
		return seq;
	endfunction

	function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
		dma_sequence_item seq;
		assert($cast(seq, bus_item));
		
		if( seq.wr_en == 1'b1 )      rw.kind = UVM_WRITE;
		else if( seq.rd_en == 1'b1 ) rw.kind = UVM_READ;

		if( seq.wr_en == 1'b1 )      rw.data = seq.wdata; 
		else if( seq.rd_en == 1'b1 ) rw.data = seq.rdata;
		
		rw.addr = seq.addr;
		rw.status = UVM_IS_OK;
	  //$display("wr_En = %b, rd_En = %B, addr = %d, wdata = %d, rdata = %d", seq.wr_en, seq.rd_en, seq.addr, seq.wdata, seq.rdata );
	endfunction

endclass
