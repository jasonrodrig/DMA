`include "dma_intr_register.sv"             
`include "dma_ctrl_register.sv"             
`include "dma_io_addr_register.sv"          
`include "dma_mem_addr_register.sv"        
`include "dma_extra_info_register.sv"      
`include "dma_status_register.sv"           
`include "dma_transfer_count_register.sv"   
`include "dma_descriptor_addr_register.sv"  
//`include "dma_error_status_register.sv"     
//`include "dma_configure_register.sv"

class dma_reg_file extends uvm_reg_file;
  `uvm_object_utils(dma_reg_file)

  rand dma_intr_reg             intr;
	rand dma_ctrl_reg             ctrl;
  rand dma_io_addr_reg          io_addr;
	rand dma_mem_addr_reg         mem_addr;
  rand dma_extra_info_reg       extra_info;
	rand dma_status_reg           status;
  rand dma_transfer_count_reg   transfer_count;
	rand dma_descriptor_addr_reg  descriptor_addr;
  //rand dma_error_status_reg     error_status;
	//rand dma_configure_reg        configure;

	function new(string name = "dma_reg_file");
		super.new(name);
	endfunction

	function void build();

  intr             = dma_intr_reg::type_id::create("intr");
	ctrl             = dma_ctrl_reg::type_id::create("ctrl");
  io_addr          = dma_io_addr_reg::type_id::create("io_addr");
	mem_addr         = dma_mem_addr_reg::type_id::create("mem_addr");
  extra_info       = dma_extra_info_reg::type_id::create("extra_info");
	status           = dma_status_reg::type_id::create("status");
  transfer_count   = dma_transfer_count_reg::type_id::create("transfer_count");
  descriptor_addr  = dma_descriptor_addr_reg::type_id::create("descriptor_addr");
  //error_status     = dma_error_status_reg::type_id::create("error_status");
	//configure        = dma_configure_reg::type_id::create("configure");

  intr.build();
  ctrl.build();
  io_addr.build();
	mem_addr.build();
  extra_info.build(); 
	status.build();
	transfer_count.build();
  descriptor_addr.build();
//	error_status.build();
//  configure.build();

 endfunction

endclass
