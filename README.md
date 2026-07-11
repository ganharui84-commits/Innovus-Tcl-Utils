# Cadence Innovus Physical Design Automation Toolkit

## Overview (项目简介)
本仓库致力于沉淀和开源在数字后端物理设计（Physical Design）过程中自主开发的高级自动化脚本。
核心聚焦于 Cadence Innovus 平台，通过 Tcl 与底层数据库（Database）的深度交互，解决标准流程中难以处理的定制化需求，如动态扫描链重组、布线拥塞优化以及时序收敛辅助等。

所有脚本均秉持 Constraint-Driven（约束驱动）理念，拒绝破坏性的物理强制操作，力求与现代顶级 EDA 工业标准接轨。

## Repository Structure (目录结构)
本仓库按芯片物理设计的标准 Flow 阶段进行模块化管理：

```text

├── scripts/
│   ├── dft-scan-reorder/        # DFT 扫描链动态追踪与自动重连模块
│   │   ├── auto_scan_Reorder.tcl
│   │   └── README.md
│   ├── floorplan_utils/         # (规划中) 宏单元摆放与电源网格规划辅助
│   └── cts_optimization/        # (规划中) 时钟树综合与 Skew 优化脚本
└── README.md                    # 全局导航与项目说明
```
##Tested Environments (实测项目背景)

本仓库内的自动化脚本均已在以下真实设计环境中完成极限测试与验证：

Target Design: LEON Processor (LEON 处理器)

Scale: > 47,000 instances (高密度实例)

EDA Platform: Cadence Innovus Implementation System

Challenge Resolved: 在无 .scandef 文件的苛刻条件下，成功利用 Tcl 内存级探测实现了上万个触发器的多并行扫描链完美重连，有效释放了布线轨道（Routing Tracks），显著优化了整体 PPA 指标。

##About the Author (关于作者)

Li Yihao (李艺浩)

Education: 电子工程/集成电路设计与集成系统专业 @ 南京邮电大学通达学院

Status: Actively seeking a Summer 2026 Digital Backend/Physical Design Internship in the Shanghai area. (目前正在积极寻找 2026 年夏季上海地区的数字后端/物理设计实习机会)

Contact:ganharui84@gmail.com

欢迎对数字后端自动化感兴趣的同仁提出 Issue 或交流探讨！
