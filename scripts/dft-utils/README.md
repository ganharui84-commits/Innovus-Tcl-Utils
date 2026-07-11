在 Innovus 终端中，在 `place_opt_design` 之前 source 该脚本：

```tcl
innovus 1> source scripts/auto_scan_reorder.tcl
innovus 2> setPlaceMode -place_global_ignore_scan true
innovus 3> place_opt_design
innovus 4> scanReorder
