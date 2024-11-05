# LBP
2016 IC Design Contest Preliminary local binary pattern


# 詳細說明

- **APR/**：此目錄包含了 APR（自動佈局與繞線）完成後的 Post-simulation 結果及相關報告。
 
  - **LBP_APR_Post_Sim_Results_with_TB/**：包含 APR 完成後的 Post-simulation 結果。
   
  - **LBP_APR_netlist.v**：LBP 電路APR 完成後的Netlist檔案，用來進行Post-simulation。
    
  - **LBP_Post_Route_Timing_Reports_Hold/**：APR後的保持時間（Hold Time）時序報告。
    
  - **LBP_Post_Route_Timing_Reports_Setup/**：APR後的設置時間（Setup Time）時序報告。
    
- **lbp_synthesis/**：此目錄包含合成過程中生成的各類報告和分析結果。
 
  - **LBP_Area/**：包含有關 LBP 電路面積分析的報告。
    
  - **LBP_power/**：包含有關 LBP 電路功耗分析的報告。
    
  - **LBP_timing_max/**：包含有關 LBP 電路最大時序分析的報告。
    
  - **LBP_timing_min/**：包含有關 LBP 電路最小時序分析的報告。
    



- **lbp_vcode/**：包含 LBP 電路的 Verilog 源碼。
 
  - **LBP.v**：LBP 電路的主要 Verilog 描述文件。
