# Verilog Tetris

A Tetris game developed using Verilog.

[![video](https://github.com/micr0dust/verilog-tetris/blob/main/img/thumbnails.jpg?raw=true "video")](https://www.youtube.com/watch?v=JI98538qdTQ)

## Display

All result are display on 8x8 LED

![video](https://github.com/micr0dust/verilog-tetris/blob/main/img/LED8x8.jpg?raw=true "video")]

## Basic Features

- Basic operation like left, right, rotate, down
- Have all the block types I, O, T, L, I, Z, S generate randomly
- During the falling, player can control the block
- Falling will stop if collision with block or bottom
- If one row filled, clear it and add score
- If stack to the top, end the game

## Extra Features

- Clear-switch can clear the 8x8 LED
- Show score when it change
- Have a button pause and display score
- You can spent one score (if you have) to let falling block smash
- At the end, you will see all block fall in void

## PINs used on FPGA

| input/output  | PIN | I/O | comment |
| --------------|-----|-----|---------|
CLR | PIN_133 | 8 DIPSW | clear 8x8 LED
left | PIN_64 | 4 BITS SW | Left button
right | PIN_67 | 4 BITS SW | Right button
rotating | PIN_66 | 4 BITS SW | Rotate button
CLK | PIN_22 | -- | clock (25 MHZ)
debugger | PIN_124 | -- |for debug use
down | PIN_65 | 4 BITS SW | Down button
SW | PIN_132 | 8 DIPSW | pause and display score
skip | PIN_129 | 8 DIPSW | spent 1 score to smash falling block
COMM[0] | PIN_68 | S0
COMM[1] | PIN_69 | S1
COMM[2] | PIN_70 | S2
COMM[3] | PIN_71 | EN | NO/OFF the LED line
DATA_B[0] | PIN_111 | CB1 |
DATA_B[1] | PIN_112 | CB2 |
DATA_B[2] | PIN_113 | CB3 |
DATA_B[3] | PIN_114 | CB4 |
DATA_B[4] | PIN_115 | CB5 |
DATA_B[5] | PIN_119 | CB6 |
DATA_B[6] | PIN_120 | CB7 |
DATA_B[7] | PIN_121 | CB8 |
DATA_G[0] | PIN_135 | CG1 |
DATA_G[1] | PIN_136 | CG2 |
DATA_G[2] | PIN_137 | CG3 |
DATA_G[3] | PIN_138 | CG4 |
DATA_G[4] | PIN_141 | CG5 |
DATA_G[5] | PIN_142 | CG6 |
DATA_G[6] | PIN_143 | CG7 |
DATA_G[7] | PIN_144 | CG8 |
DATA_R[0] | PIN_72 | CR1 |
DATA_R[1] | PIN_73 | CR2 |
DATA_R[2] | PIN_74 | CR3 |
DATA_R[3] | PIN_75 | CR4 |
DATA_R[4] | PIN_76 | CR5 |
DATA_R[5] | PIN_77 | CR6 |
DATA_R[6] | PIN_79 | CR7 |
DATA_R[7] | PIN_80 | CR8 |

## Compilation Info

| | |
|----|----|
Quartus II 64-Bit Version | 13.1.0 Build 162 10/23/2013 SJ Web Edition
Revision Name | tetris
Top-level Entity Name | tetris
Family | Cyclone III
Device | EP3C10E144C8
Total logic elements | 1,398 / 10,320 ( 14 % )
Total combinational functions | 1,367 / 10,320 ( 13 % )
Dedicated logic registers | 295 / 10,320 ( 3 % )
Total registers | 295
Total pins | 37 / 95 ( 39 % )
