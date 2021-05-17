transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {uart_tx.vo}

vlog -vlog01compat -work work +incdir+C:/Users/USER/Desktop/uart_tx {C:/Users/USER/Desktop/uart_tx/hw1_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  hw1_tb

add wave *
view structure
view signals
run -all
