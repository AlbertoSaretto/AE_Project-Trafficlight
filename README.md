# AE_Project-Trafficlight

Design and implementation of a trafficlight on a FPGA.

In this project we have worked on the design and implementation on a FPGA of a complete trafficlight with the use of Verilog on Xilinx Vivado.
The project have been developed starting from the code proposed during the Applied Electronics course, adding functionalities such as sound output, pedestrian states and Off state.

The **constraints** repository contains constraints for the Vivado project including the definition of the used I/Os. it contains general .xdc for the Arty A7-100 Rev. D.

The **synthesis** repository contains the following design sources:

* **top:** design of the complete trafficlight functionality together with the I/Os ports used by the FPGA.
* **blinker:** generates a 50% duty cycle square-wave of a given period.
* **sound:** module for the generation of square signal of tunable frequency.
* **DBCs:** debouncing modules for input signals from buttons and switches.
* **light:** The light module transforms a 3-bit signal into a color-coded output for the Arty board.
* **control** The control module implements the State Machine prforming the traffic light operations.
