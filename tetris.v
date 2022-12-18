module tetris(
	output reg [7:0] map0,map1,map2,map3,map4,map5,map6,map7,
    output reg [7:0] debug1,debugger,
	input CLK, CLR, right, left, rotating
);
    // const
    reg [7:0] shapes[6:0][3:0][3:0];
    reg [3:0] shapesH[6:0];
    parameter[4:0] TOP = 17, BUTTOM = 10;

	initial begin
        // shapes define
        shapes[0][0][0]<=8'b11110000;shapes[0][0][1]<=8'b00000000;shapes[0][0][2]<=8'b00000000;shapes[0][0][3]<=8'b00000000;shapes[0][1][0]<=8'b10000000;shapes[0][1][1]<=8'b10000000;shapes[0][1][2]<=8'b10000000;shapes[0][1][3]<=8'b10000000;shapes[0][2][0]<=8'b11110000;shapes[0][2][1]<=8'b00000000;shapes[0][2][2]<=8'b00000000;shapes[0][2][3]<=8'b00000000;shapes[0][3][0]<=8'b10000000;shapes[0][3][1]<=8'b10000000;shapes[0][3][2]<=8'b10000000;shapes[0][3][3]<=8'b10000000;
        shapes[1][0][0]<=8'b11000000;shapes[1][0][1]<=8'b11000000;shapes[1][0][2]<=8'b00000000;shapes[1][0][3]<=8'b00000000;shapes[1][1][0]<=8'b11000000;shapes[1][1][1]<=8'b11000000;shapes[1][1][2]<=8'b00000000;shapes[1][1][3]<=8'b00000000;shapes[1][2][0]<=8'b11000000;shapes[1][2][1]<=8'b11000000;shapes[1][2][2]<=8'b00000000;shapes[1][2][3]<=8'b00000000;shapes[1][3][0]<=8'b11000000;shapes[1][3][1]<=8'b11000000;shapes[1][3][2]<=8'b00000000;shapes[1][3][3]<=8'b00000000;
        shapes[2][0][0]<=8'b11100000;shapes[2][0][1]<=8'b01000000;shapes[2][0][2]<=8'b00000000;shapes[2][0][3]<=8'b00000000;shapes[2][1][0]<=8'b01000000;shapes[2][1][1]<=8'b11000000;shapes[2][1][2]<=8'b01000000;shapes[2][1][3]<=8'b00000000;shapes[2][2][0]<=8'b01000000;shapes[2][2][1]<=8'b11100000;shapes[2][2][2]<=8'b00000000;shapes[2][2][3]<=8'b00000000;shapes[2][3][0]<=8'b10000000;shapes[2][3][1]<=8'b11000000;shapes[2][3][2]<=8'b10000000;shapes[2][3][3]<=8'b00000000;
        shapes[3][0][0]<=8'b11100000;shapes[3][0][1]<=8'b10000000;shapes[3][0][2]<=8'b00000000;shapes[3][0][3]<=8'b00000000;shapes[3][1][0]<=8'b11000000;shapes[3][1][1]<=8'b01000000;shapes[3][1][2]<=8'b01000000;shapes[3][1][3]<=8'b00000000;shapes[3][2][0]<=8'b00100000;shapes[3][2][1]<=8'b11100000;shapes[3][2][2]<=8'b00000000;shapes[3][2][3]<=8'b00000000;shapes[3][3][0]<=8'b10000000;shapes[3][3][1]<=8'b10000000;shapes[3][3][2]<=8'b11000000;shapes[3][3][3]<=8'b00000000;
        shapes[4][0][0]<=8'b11100000;shapes[4][0][1]<=8'b00100000;shapes[4][0][2]<=8'b00000000;shapes[4][0][3]<=8'b00000000;shapes[4][1][0]<=8'b01000000;shapes[4][1][1]<=8'b01000000;shapes[4][1][2]<=8'b11000000;shapes[4][1][3]<=8'b00000000;shapes[4][2][0]<=8'b10000000;shapes[4][2][1]<=8'b11100000;shapes[4][2][2]<=8'b00000000;shapes[4][2][3]<=8'b00000000;shapes[4][3][0]<=8'b11000000;shapes[4][3][1]<=8'b10000000;shapes[4][3][2]<=8'b10000000;shapes[4][3][3]<=8'b00000000;
        shapes[5][0][0]<=8'b11000000;shapes[5][0][1]<=8'b01100000;shapes[5][0][2]<=8'b00000000;shapes[5][0][3]<=8'b00000000;shapes[5][1][0]<=8'b01000000;shapes[5][1][1]<=8'b11000000;shapes[5][1][2]<=8'b10000000;shapes[5][1][3]<=8'b00000000;shapes[5][2][0]<=8'b11000000;shapes[5][2][1]<=8'b01100000;shapes[5][2][2]<=8'b00000000;shapes[5][2][3]<=8'b00000000;shapes[5][3][0]<=8'b01000000;shapes[5][3][1]<=8'b11000000;shapes[5][3][2]<=8'b10000000;shapes[5][3][3]<=8'b00000000;
        shapes[6][0][0]<=8'b01100000;shapes[6][0][1]<=8'b11000000;shapes[6][0][2]<=8'b00000000;shapes[6][0][3]<=8'b00000000;shapes[6][1][0]<=8'b10000000;shapes[6][1][1]<=8'b11000000;shapes[6][1][2]<=8'b01000000;shapes[6][1][3]<=8'b00000000;shapes[6][2][0]<=8'b01100000;shapes[6][2][1]<=8'b11000000;shapes[6][2][2]<=8'b00000000;shapes[6][2][3]<=8'b00000000;shapes[6][3][0]<=8'b10000000;shapes[6][3][1]<=8'b11000000;shapes[6][3][2]<=8'b01000000;shapes[6][3][3]<=8'b00000000;
        // shapes height define
        shapesH[0][0]<=1;shapesH[0][1]<=4;shapesH[0][2]<=1;shapesH[0][3]<=4;shapesH[1][0]<=2;shapesH[1][1]<=2;shapesH[1][2]<=2;shapesH[1][3]<=2;shapesH[2][0]<=2;shapesH[2][1]<=3;shapesH[2][2]<=2;shapesH[2][3]<=3;shapesH[3][0]<=2;shapesH[3][1]<=3;shapesH[3][2]<=2;shapesH[3][3]<=3;shapesH[4][0]<=2;shapesH[4][1]<=3;shapesH[4][2]<=2;shapesH[4][3]<=3;shapesH[5][0]<=2;shapesH[5][1]<=3;shapesH[5][2]<=2;shapesH[5][3]<=3;shapesH[6][0]<=2;shapesH[6][1]<=3;shapesH[6][2]<=2;shapesH[6][3]<=3;
    end
    /*
    scene
        0: game end
        1: anime time
        2: cleaning line
        3: start but no block
        4: falling
        5: check and erase
    */
    /*
    blockType
        0: I
        1: O
        2: T
        3: L
        4: J
        5: Z
        6: S
    */

    // controller
    reg[2:0] controller;

    // action
    reg rightAction;
    reg leftAction;
    reg rotateAction;

    //random
    reg [7:0] random;

    // timer
    Timer2 T2(CLK,timer2);
    Timer10 T10(CLK,timer10);

    // tmp use
    integer i,j,k;

    // CLK
    reg[2:0] scene;

    // simulate next action
    reg[5:0] tryBlockX;
    reg[3:0] tryRotate;
    reg[3:0] nextTryRotate;

    // valid action?
    reg[1:0] nextRotate;
    reg[5:0] nextBlockX;

    // final check
    reg [7:0] map[7:0];
    reg [7:0] display[7:0];
    reg [2:0] nextScene;
    reg [1:0] rotate;
    reg [5:0] blockX, blockY;
    reg [2:0] blockType;

    // next blockY
    reg [5:0] nextBlockY;

    initial 
        begin
            controller <= 0;
            scene <= 0;
            random <= 0;
            blockX <= 0;
            blockY <= 0;
            nextBlockY <= 0;
            rotate <= 0;
            nextScene <= 0;
            for (i=0; i<8; i=i+1)
                for (j=0; j<8; j=j+1)
                    map[i][j] <= 8'b0;
        end

    // action
    always@(posedge CLK)
    begin
        rightAction <= right;
        leftAction <= left;
        rotateAction <= rotating;
        if(controller==3)
            controller <= 0;
        else controller <= controller + 1;
    end

    // random
    always@(posedge CLK)
    begin
        if(random==127) random <= 7'b0;
        else random <= random+1;
    end

    // simulate next action
    always@(posedge CLK)
    if(controller==0)
    begin
        tryRotate <= rotate;
        tryBlockX <= blockX;
        if (rotateAction)
        case(rotate)
            2'b00: tryRotate <= 2'b01;
            2'b01: tryRotate <= 2'b10;
            2'b10: tryRotate <= 2'b11;
            2'b11: tryRotate <= 2'b00;
        endcase
        else if (leftAction && tryBlockX > 0)
            tryBlockX <= tryBlockX-1;
        else if (rightAction)
            tryBlockX <= tryBlockX+1;
        
        case(tryRotate)
            2'b00: nextTryRotate <= 2'b01;
            2'b01: nextTryRotate <= 2'b10;
            2'b10: nextTryRotate <= 2'b11;
            2'b11: nextTryRotate <= 2'b00;
        endcase
        if ((tryBlockX+shapesH[blockType][nextTryRotate]-1) > 7)
            tryBlockX <= blockX;
    end

    // valid action?
    always@(posedge CLK)
    if(controller==1)
    begin
        nextRotate <= tryRotate;
        nextBlockX <= tryBlockX;
        if((map[(TOP-blockY) + 0] & (shapes[blockType][nextRotate][0] >> nextBlockX)) ||
            (map[(TOP-blockY) + 1] & (shapes[blockType][nextRotate][1] >> nextBlockX)) ||
            (map[(TOP-blockY) + 2] & (shapes[blockType][nextRotate][2] >> nextBlockX)) ||
            (map[(TOP-blockY) + 3] & (shapes[blockType][nextRotate][3] >> nextBlockX)))
        begin
            nextRotate <= rotate;
            nextBlockX <= blockX;
        end
    end

    // final check
    always@(posedge CLK)
    if(CLR)begin
        for (i=0; i<8; i=i+1)
            for (j=0; j<8; j=j+1)
                map[i][j] = 8'b0;
        nextScene <= 0;
    end
    else if(controller==2)
    case (scene)
        0: begin
            for(i = 7; i >= 0; i = i-1)
                if(i > 0)
                    map[i] <= map[i-1];
                else
                    map[i] <= 8'b00000000;
            for (i = 0; i<8; i=i+1)
                    display[i] <= map[i];
            if(map[0]||map[1]||map[2]||map[3]||map[4]||map[5]||map[6]||map[7])
                nextScene <= 0;
            else
                nextScene <= 1;
        end
        1: begin
            if(rightAction||leftAction||rotateAction)
                nextScene <= 3;
        end
        3: begin
            blockType <= random % 7;
            rotate <= random % 4;
            blockX <= random % 5;
            nextBlockY <= (TOP + shapesH[random % 7][random % 4]);
            nextScene <= 4;
        end
        4: begin // falling
            nextBlockY <= blockY - 1;
            blockX <= blockX;
            rotate <= nextRotate;
            // endGame 
            if(map[0])
            begin
                nextScene <= 0;
            end
            // collision
            else if((
            (shapes[blockType][rotate][0] && blockY-0 <= BUTTOM) ||
            (shapes[blockType][rotate][1] && blockY-1 <= BUTTOM) ||
            (shapes[blockType][rotate][2] && blockY-2 <= BUTTOM) ||
            (shapes[blockType][rotate][3] && blockY-3 <= BUTTOM))
             || (
            ((blockY - 1) <= TOP && (map[TOP - (blockY - 1)] & (shapes[blockType][rotate][0] >> blockX))) ||
            ((blockY - 2) <= TOP && (map[TOP - (blockY - 2)] & (shapes[blockType][rotate][1] >> blockX))) ||
            ((blockY - 3) <= TOP && (map[TOP - (blockY - 3)] & (shapes[blockType][rotate][2] >> blockX))) ||
            ((blockY - 4) <= TOP && (map[TOP - (blockY - 4)] & (shapes[blockType][rotate][3] >> blockX)))
            ))
            begin
                debugger <= 1;
                map[TOP - (blockY - 0)] <= map[TOP - (blockY - 0)] | (shapes[blockType][rotate][0] >> blockX);
                map[TOP - (blockY - 1)] <= map[TOP - (blockY - 1)] | (shapes[blockType][rotate][1] >> blockX);
                map[TOP - (blockY - 2)] <= map[TOP - (blockY - 2)] | (shapes[blockType][rotate][2] >> blockX);
                map[TOP - (blockY - 3)] <= map[TOP - (blockY - 3)] | (shapes[blockType][rotate][3] >> blockX);
                for (i = 0; i<8; i=i+1)
                    display[i] <= map[i];
                display[TOP - (blockY - 0)] <= map[TOP - (blockY - 0)] | (shapes[blockType][rotate][0] >> blockX);
                display[TOP - (blockY - 1)] <= map[TOP - (blockY - 1)] | (shapes[blockType][rotate][1] >> blockX);
                display[TOP - (blockY - 2)] <= map[TOP - (blockY - 2)] | (shapes[blockType][rotate][2] >> blockX);
                display[TOP - (blockY - 3)] <= map[TOP - (blockY - 3)] | (shapes[blockType][rotate][3] >> blockX);
                nextScene <= 3;
            end
            else
            begin
                // erase
                debugger <= 0;
                for (i = 0; i<8; i=i+1)
                    display[i] <= map[i];
                display[TOP - (blockY - 0)] <= map[TOP - (blockY - 0)] | (shapes[blockType][rotate][0] >> blockX);
                display[TOP - (blockY - 1)] <= map[TOP - (blockY - 1)] | (shapes[blockType][rotate][1] >> blockX);
                display[TOP - (blockY - 2)] <= map[TOP - (blockY - 2)] | (shapes[blockType][rotate][2] >> blockX);
                display[TOP - (blockY - 3)] <= map[TOP - (blockY - 3)] | (shapes[blockType][rotate][3] >> blockX);
                nextScene <= 4;
            end
        end
        5: begin //check and erase
            if(map[(TOP - blockY) + shapesH[blockType][rotate]-1] == 8'b11111111) begin
                for(i = 7; i >= 0; i = i-1)
                    if(i <= (TOP - blockY) + shapesH[blockType][rotate]-1)
                        if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            end
            else if(shapesH[blockType][rotate] >= 2 && map[(TOP - blockY) + shapesH[blockType][rotate]-2] == 8'b11111111) begin
                for(i = 7; i >= 0; i = i-1)
                    if(i <= (TOP - blockY) + shapesH[blockType][rotate]-2)
                        if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            end
            else if(shapesH[blockType][rotate] >= 3 && map[(TOP - blockY) + shapesH[blockType][rotate]-3] == 8'b11111111) begin
                for(i = 7; i >= 0; i = i-1)
                    if(i <= (TOP - blockY) + shapesH[blockType][rotate]-3)
                        if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            end
            else if(shapesH[blockType][rotate] >= 4 && map[(TOP - blockY) + shapesH[blockType][rotate]-4] == 8'b11111111) begin
                for(i = 7; i >= 0; i = i-1)
                    if(i <= (TOP - blockY) + shapesH[blockType][rotate]-4)
                        if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            end
            else nextScene <= 4;
        end
    endcase

    always@(posedge CLK)
    if(controller==3)
    begin
        blockY <= nextBlockY;
    end

    // display
    always@(posedge CLK)
    if(controller==3)
    begin
        scene <= nextScene;
        debug1 <= scene;
        map0 <= display[0];
        map1 <= display[1];
        map2 <= display[2];
        map3 <= display[3];
        map4 <= display[4];
        map5 <= display[5];
        map6 <= display[6];
        map7 <= display[7];
    end
    
        
endmodule

// 0.5s , 2hz
module Timer2(input CLK, output reg CLK2);
	reg [24:0] timer=0;
	always @(posedge CLK)
	begin
		if(timer > 12500000)
		begin
			timer <= 0;
			CLK2 <= ~CLK2;
		end
		else
			timer <= timer + 1;
	end
endmodule

// 0.01s , 10hz
module Timer10(input CLK, output reg CLK10);
	reg [24:0] timer=0;
	always @(posedge CLK)
	begin
		if(timer > 2500000)
		begin
			timer <= 0;
			CLK10 <= ~CLK10;
		end
		else
			timer <= timer + 1;
	end
endmodule