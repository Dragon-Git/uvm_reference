//
// Template for UVM-compliant RAL adapter sequence (multi)
// <REGTR>   Name of the RAL adapter sequence
// <REGTR1>   Name of the RAL adapter sequence for second domain
// <TR>   Name of the transaction descriptor 
// <TR1>  Name of the transaction descriptor of second domain 
//

class REGTR extends uvm_reg_adapter;

`uvm_object_utils(REGTR)
 function new (string name="");
   super.new(name);
 endfunction

 virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  TR tr;
  tr = TR::type_id::create("tr");
  tr.kind = (rw.kind == UVM_READ) ? TR::READ : TR::WRITE;
  //tr.addr = rw.addr;
  //tr.data = rw.data;
  return tr;
 endfunction

 virtual function void bus2reg (uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
  TR tr;
  if (!$cast(tr, bus_item))
   `uvm_fatal("NOT_HOST_REG_TYPE", "bus_item is not correct type");
  rw.kind = tr.kind ? UVM_READ : UVM_WRITE;
  //rw.addr = tr.addr;
  //rw.data = tr.data;
  //rw.status = UVM_IS_OK;
 endfunction

endclass: REGTR

class REGTR1 extends uvm_reg_adapter;

`uvm_object_utils(REGTR1)

 function new (string name="");
   super.new(name);
 endfunction
 
 virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  TR1 tr;
  tr = TR1::type_id::create("tr");
  tr.kind = (rw.kind == UVM_READ) ? TR1::READ : TR1::WRITE;
  //tr.addr = rw.addr;
  //tr.data = rw.data;
  return tr;
 endfunction

 virtual function void bus2reg (uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
  TR1 tr;
  if (!$cast(tr, bus_item))
   `uvm_fatal("NOT_HOST_REG_TYPE", "bus_item is not correct type");
  rw.kind = tr.kind ? UVM_READ : UVM_WRITE;
  //rw.addr = tr.addr;
  //rw.data = tr.data;
  // rw.status = UVM_IS_OK;
 endfunction

endclass: REGTR1

//ToDo: Any more domains can be added here in a similar way as shown above
