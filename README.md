# LBP
2016 IC Design Contest Preliminary local binary pattern


# 詳細說明

- **APR/**：此目錄包含了 APR（自動佈局與繞線）完成後的 Post-simulation 結果及相關報告。
  - **LBP_APR_Post_Sim_Results_with_TB/**：包含 APR 完成後的 Post-simulation 結果。
  - **LBP_APR_netlist.v**：LBP 電路的Netlist檔案，經由合成工具生成，用於後續的布局與路由及模擬。
  - **LBP_Post_Route_Timing_Reports_Hold/**：APR後的保持時間（Hold Time）時序報告。
  - **LBP_Post_Route_Timing_Reports_Setup/**：APR後的設置時間（Setup Time）時序報告。

- **lbp_vcode/**：包含 LBP 電路的 Verilog 源碼。
  - **LBP.v**：LBP 電路的主要 Verilog 描述文件。
