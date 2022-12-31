# Verilog Tetris

A Tetris game made with Verilog.

## Basic Features

- Basic operation like left, right, rotate, down
- Have all the block types I, O, T, L, J, Z, S
- If one row filled, clear it and add score
- If stack to the top, end the game

## Extra Features

- Clear switch that can clear the 8x8 LED
- Show score when it change
- Have a button pause and display score
- You can spent one score (if you have) to let falling block smash
- At the end, you will see all block fall in void

## PINs used on FPGA

| input/output  | PIN |
|----|----|
CLR | PIN_133
COMM[0] | PIN_68
COMM[1] | PIN_69
COMM[2] | PIN_70
COMM[3] | PIN_71
DATA_B[0] | PIN_111
DATA_B[1] | PIN_112
DATA_B[2] | PIN_113
DATA_B[3] | PIN_114
DATA_B[4] | PIN_115
DATA_B[5] | PIN_119
DATA_B[6] | PIN_120
DATA_B[7] | PIN_121
DATA_G[0] | PIN_135
DATA_G[1] | PIN_136
DATA_G[2] | PIN_137
DATA_G[3] | PIN_138
DATA_G[4] | PIN_141
DATA_G[5] | PIN_142
DATA_G[6] | PIN_143
DATA_G[7] | PIN_144
DATA_R[0] | PIN_72
DATA_R[1] | PIN_73
DATA_R[2] | PIN_74
DATA_R[3] | PIN_75
DATA_R[4] | PIN_76
DATA_R[5] | PIN_77
DATA_R[6] | PIN_79
DATA_R[7] | PIN_80
left | PIN_64
right | PIN_67
rotating | PIN_66
CLK | PIN_22
debugger | PIN_124
down | PIN_65
SW | PIN_132
skip | PIN_129
