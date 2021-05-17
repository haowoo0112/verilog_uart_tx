# verilog_uart_tx

1. UART TX，BaudRate：9600，Data： 8 Bit，None Parity，1 Stop Bit。
2. 每次（write）輸入信號負緣後，讀取(write_value)當作TX Data ，並開始傳送UART
TXD

| MODULE        | DESCRIPTION                                        |
| ------------- | -------------------------------------------------- |
| edge_detect.v | gives one-tick pulses on every signal falling edge |
| uart_tx_tb    | testbench                                          |
| uart_tx       | main                                               |
## UART TXD
![](https://i.imgur.com/Qqrov2B.png)
