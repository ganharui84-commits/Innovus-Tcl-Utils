# ==============================================================================
# 1. 动态探测并指定扫描链 (究极防呆版)
# ==============================================================================

# 把输入和输出统统抓进列表
set all_ins [dbGet top.terms.name BG_scan_in*]
set all_outs [dbGet top.terms.name BG_scan_out*]

# 检查并获取长度（防止 0x0 空指针导致 llength 报错）
set in_len  [if {$all_ins == "0x0"}  {expr 0} else {llength $all_ins}]
set out_len [if {$all_outs == "0x0"} {expr 0} else {llength $all_outs}]

if {$in_len == 0 && $out_len == 0} {
    puts "CDF-ERROR: 致命错误，未探测到任何扫描端口！"
} else {
    # 核心修复：用 expr 算出 input 和 output 中较大的那个数值！
    set auto_max_chains [expr {$in_len > $out_len ? $in_len : $out_len}]
    
    # 额外加一层保险：考虑到可能有跳号的情况，把扫描上限强行放大一点点（比如加10）也是极其安全的，因为内部的 if 会自动过滤掉不存在的端口
    set safe_loop_max [expr {$auto_max_chains + 10}]
    
    puts "CDF-INFO: 雷达探测完毕。Input数量: $in_len, Output数量: $out_len."
    puts "CDF-INFO: 为确保无遗漏，安全循环上限设定为: $safe_loop_max"

    set valid_chain_count 0

    # 用最大的安全上限去跑循环
    for {set i 1} {$i <= $safe_loop_max} {incr i} {
        
        if {$i == 1} {
            set in_port "BG_scan_in"
            set out_port "BG_scan_out"
        } else {
            set in_port "BG_scan_in_$i"
            set out_port "BG_scan_out_$i"
        }
        
        set in_exists [dbGet top.terms.name $in_port]
        set out_exists [dbGet top.terms.name $out_port]
        
        # 严格配对机制：只有在当前的 i 下，in 和 out 都真实存在，才连成一条链
        if {$in_exists != "0x0" && $out_exists != "0x0"} {
            specifyScanChain chain_$i -start $in_port -stop $out_port
            incr valid_chain_count
        }
    }

    puts "---------------------------------------------------"
    puts "CDF-INFO: 最终成功指定了 $valid_chain_count 条完美配对的扫描链族谱。"
    puts "---------------------------------------------------"
}