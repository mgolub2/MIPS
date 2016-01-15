/*
Wrapper for Xilinx Tri-mode mac and MII to RMII interface
*/

module ethernet_core();

memory_mapped_ethernet ethernet (
  .glbl_rstn(rst_n),                              // input wire glbl_rstn
  .rx_axi_rstn(rx_axi_rstn),                          // input wire rx_axi_rstn
  .tx_axi_rstn(tx_axi_rstn),                          // input wire tx_axi_rstn
  .rx_statistics_vector(rx_statistics_vector),        // output wire [27 : 0] rx_statistics_vector
  .rx_statistics_valid(rx_statistics_valid),          // output wire rx_statistics_valid
  .rx_mac_aclk(rx_mac_aclk),                          // output wire rx_mac_aclk
  .rx_reset(rx_reset),                                // output wire rx_reset
  .rx_enable(rx_enable),                              // output wire rx_enable
  .rx_axis_mac_tdata(rx_axis_mac_tdata),              // output wire [7 : 0] rx_axis_mac_tdata
  .rx_axis_mac_tvalid(rx_axis_mac_tvalid),            // output wire rx_axis_mac_tvalid
  .rx_axis_mac_tlast(rx_axis_mac_tlast),              // output wire rx_axis_mac_tlast
  .rx_axis_mac_tuser(rx_axis_mac_tuser),              // output wire rx_axis_mac_tuser
  .tx_ifg_delay(tx_ifg_delay),                        // input wire [7 : 0] tx_ifg_delay
  .tx_statistics_vector(tx_statistics_vector),        // output wire [31 : 0] tx_statistics_vector
  .tx_statistics_valid(tx_statistics_valid),          // output wire tx_statistics_valid
  .tx_mac_aclk(tx_mac_aclk),                          // output wire tx_mac_aclk
  .tx_reset(tx_reset),                                // output wire tx_reset
  .tx_enable(tx_enable),                              // output wire tx_enable
  .tx_axis_mac_tdata(tx_axis_mac_tdata),              // input wire [7 : 0] tx_axis_mac_tdata
  .tx_axis_mac_tvalid(tx_axis_mac_tvalid),            // input wire tx_axis_mac_tvalid
  .tx_axis_mac_tlast(tx_axis_mac_tlast),              // input wire tx_axis_mac_tlast
  .tx_axis_mac_tuser(tx_axis_mac_tuser),              // input wire [0 : 0] tx_axis_mac_tuser
  .tx_axis_mac_tready(tx_axis_mac_tready),            // output wire tx_axis_mac_tready
  .pause_req(pause_req),                              // input wire pause_req
  .pause_val(pause_val),                              // input wire [15 : 0] pause_val
  .speedis100(speedis100),                            // output wire speedis100
  .speedis10100(speedis10100),                        // output wire speedis10100
  .mii_tx_clk(mii_tx_clk),                            // input wire mii_tx_clk
  .mii_txd(mii_txd),                                  // output wire [3 : 0] mii_txd
  .mii_tx_en(mii_tx_en),                              // output wire mii_tx_en
  .mii_tx_er(mii_tx_er),                              // output wire mii_tx_er
  .mii_rxd(mii_rxd),                                  // input wire [3 : 0] mii_rxd
  .mii_rx_dv(mii_rx_dv),                              // input wire mii_rx_dv
  .mii_rx_er(mii_rx_er),                              // input wire mii_rx_er
  .mii_rx_clk(mii_rx_clk),                            // input wire mii_rx_clk
  .rx_configuration_vector(rx_configuration_vector),  // input wire [79 : 0] rx_configuration_vector
  .tx_configuration_vector(tx_configuration_vector)  // input wire [79 : 0] tx_configuration_vector
);

mii_to_rmii_0 converter (
  .rst_n(rst_n),                      // input wire rst_n
  .ref_clk(ref_clk),                  // input wire ref_clk
  .mac2rmii_tx_en(mac2rmii_tx_en),    // input wire mac2rmii_tx_en
  .mac2rmii_txd(mac2rmii_txd),        // input wire [3 : 0] mac2rmii_txd
  .mac2rmii_tx_er(mac2rmii_tx_er),    // input wire mac2rmii_tx_er
  .rmii2mac_tx_clk(rmii2mac_tx_clk),  // output wire rmii2mac_tx_clk
  .rmii2mac_rx_clk(rmii2mac_rx_clk),  // output wire rmii2mac_rx_clk
  .rmii2mac_col(rmii2mac_col),        // output wire rmii2mac_col
  .rmii2mac_crs(rmii2mac_crs),        // output wire rmii2mac_crs
  .rmii2mac_rx_dv(rmii2mac_rx_dv),    // output wire rmii2mac_rx_dv
  .rmii2mac_rx_er(rmii2mac_rx_er),    // output wire rmii2mac_rx_er
  .rmii2mac_rxd(rmii2mac_rxd),        // output wire [3 : 0] rmii2mac_rxd
  .phy2rmii_crs_dv(phy2rmii_crs_dv),  // input wire phy2rmii_crs_dv
  .phy2rmii_rx_er(phy2rmii_rx_er),    // input wire phy2rmii_rx_er
  .phy2rmii_rxd(phy2rmii_rxd),        // input wire [1 : 0] phy2rmii_rxd
  .rmii2phy_txd(rmii2phy_txd),        // output wire [1 : 0] rmii2phy_txd
  .rmii2phy_tx_en(rmii2phy_tx_en)    // output wire rmii2phy_tx_en
);

endmodule // ethernet_core