//
// Template for UVM-compliant verification environment
// <CFG>       Name of the configuration class
// <SB>        Name of Scoreboard class
// <TR>        Name of the transaction descriptor
// <XACT>      Name of the driver
// <MON>       Name of the monitor class
// <COV>       Name of the coverage class
//

`ifndef VNAME__SV
`define VNAME__SV

INCL_IFTR_START
`include "tr_file_list.sv"
`include "MON.sv"

SING_DRV_START
`include "XACT.sv"
`include "SEQR.sv"  
SING_DRV_END

MULT_DRV_START
`include "XACT.sv"   //UVMGEN_RPT_ON_XACT
`include "SEQR.sv"  //UVMGEN_RPT_ON_SEQR
//ToDo: If you have multiple drivers in the environment, Include other drivers here. 
MULT_DRV_END
INCL_IFTR_END


MNTR_INCL_START
MNTR_OBS_MTHD_ONE_START
`include "MON.sv"
MNTR_OBS_MTHD_ONE_END
MNTR_INCL_END

MAST_START
`include "mstr_slv_src.incl"
MAST_END

`include "CFG.sv"

SCN_GEN_START
`include "SCEN.sv"
//ToDo: Include required sequence files
SCN_GEN_END

SCBD_EN_START
`include "SB.sv"
SCBD_EN_END

`include "COV.sv"
MNTR_OBS_MTHD_ONE_START
`include "mon_2cov.sv"
MNTR_OBS_MTHD_ONE_END

MNTR_OBS_MTHD_TWO_START
MNTR_OBS_MTHD_TWO_Q_START
`include "mon_2cov.sv"
MNTR_OBS_MTHD_TWO_Q_END
MNTR_OBS_MTHD_TWO_END

INCL_IFTR_START
RAL_START
SING_DM_START
`include "ral_single.sv"
SING_DM_END
MULT_DM_START
`include "ral_multiplexed.sv"
//ToDo : Include other RAL BFM files, if more than two domains are used.

MULT_DM_END
`include "ral_VNAME.sv"
RAL_END
INCL_IFTR_END

MAST_START
RAL_START
SING_DM_START
`include "ral_single.sv"
SING_DM_END
MULT_DM_START
`include "ral_multiplexed.sv"
//ToDo : Include other RAL BFM files, if more than two domains are used.

MULT_DM_END
`include "ral_VNAME.sv"
RAL_END
MAST_END
// ToDo: Add additional required `include directives

`endif // VNAME__SV
