## 📌 Overview (项目简介)
This repository contains a collection of Tcl and Python scripts designed to automate and optimize the digital backend physical design flow using Cadence Innovus. These utilities are developed to handle complex IC designs, improving routing congestion, timing closure, and DFT (Design for Testability) integration.

## 🛠️ Environment (运行环境)
*   **EDA Tool:** Cadence Innovus Implementation System
*   **Language:** Tcl 8.5+, Python 3.x

## 🚀 Key Scripts (核心脚本说明)

### 1. Auto-Scan-Chain Detection & Reordering (`auto_scan_reorder.tcl`)
*   **Description:** 在缺乏 `.scandef` 文件的情况下，利用 `dbGet` 底层指针动态探测全芯片的 `Scan In / Scan Out` 端口，自动计算并配对扫描链（支持多链并行及不对称出入口），并指导 Innovus 布局引擎执行 `scanReorder`。
*   **Highlights:** 
    *   摒弃暴力的物理断线（`detachTerm`），采用纯净的 Constraint-Driven 流程。
    *   具备极限边界防护（Corner-case protection），有效应对缺失断点或跳号命名的端口。
    *   在类似 LEON 处理器（>47,000 instances）的密集设计中，可有效缓解布线拥塞。

## 📖 Usage (使用方法)
在 Innovus 终端中，在 `place_opt_design` 之前 source 该脚本：

```tcl
innovus 1> source scripts/auto_scan_reorder.tcl
innovus 2> setPlaceMode -place_global_ignore_scan true
innovus 3> place_opt_design
innovus 4> scanReorder
