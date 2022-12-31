`timescale 1ns / 1ps

module tetris(
	output reg [7:0] DATA_R, DATA_G, DATA_B ,
    output reg [3:0] COMM,
    output reg debugger,
	input CLK, CLR, right, left, rotating, down
);
    // const
    reg [7:0] shapes[6:0][3:0][3:0];
    reg [2:0] shapesH[6:0][3:0];
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
    reg[4:0] controller;
    reg nextRound;
    reg round;

    // action
    reg rightAction;
    reg leftAction;
    reg rotateAction;
    reg downAction;
    reg rightNext;
    reg leftNext;
    reg rotateNext;
    reg downNext;
    reg [3:0] delay;

    //random
    reg [7:0] random;

    // timer
    Timer2 T2(CLK,timer2);
    Timer25 T25(CLK,timer25);
    TimerRefresh TFR(CLK,refresh);

    // tmp use
    integer i,j,k;

    // CLK
    reg[2:0] scene;

    // simulate next action
    reg[5:0] tryBlockX;
    reg[3:0] tryRotate;

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
    reg [4:0] animeCount;

    // next blockY
    reg [5:0] nextBlockY;

    initial 
        begin
            round <= 0;
            nextRound <= 0;
            delay <= 0;
            rightNext <= 0;
            leftNext <= 0;
            rotateNext <= 0;
            downNext <= 0;
            debugger <= 0;
            COMM <= 4'b1000;
            DATA_R <= 8'b11111111;
            DATA_G <= 8'b11111111;
            DATA_B <= 8'b11111111;
            rightAction <= 0;
            leftAction <= 0;
            rotateAction <= 0;
            controller <= 0;
            scene <= 0;
            random <= 0;
            blockX <= 0;
            blockY <= 0;
            nextBlockY <= 0;
            rotate <= 0;
            nextScene <= 0;
            animeCount <= 0;
            for (i=0; i<8; i=i+1)
                for (j=0; j<8; j=j+1)
                    map[i][j] <= 8'b0;
        end

    // controller
    always@(posedge refresh)
    begin
        if(controller==13)
            controller <= 0;
        else controller <= controller + 1;
    end

    // action
    always@(posedge refresh)
    if(controller==0)
    begin
        if(!delay) begin
            rightNext <= right;
            leftNext <= left;
            rotateNext <= rotating;
            downNext <= down;
            delay <= delay + 1;
        end
        else delay <= delay + 1;
    end

    // random
    always@(posedge refresh)
    begin
        random <= random+1;
    end

    // simulate next action
    always@(posedge refresh)
    if(controller==1)
    begin
        if(!rotateAction && rotateNext)
            tryRotate <= (rotate+1)%4;
        else
            tryRotate <= rotate;

        if (!leftAction && leftNext && blockX > 0)
            tryBlockX <= blockX-1;
        else if (!rightAction && rightNext)
            tryBlockX <= blockX+1;
        else
            tryBlockX <= blockX;
    end

    // valid action?
    always@(posedge refresh)
    if(controller==2)
    begin
        if(((tryBlockX+shapesH[blockType][(tryRotate&1)+1]-1) > 7) ||
            (map[(TOP-blockY) + 0] & (shapes[blockType][tryRotate][0] >> tryBlockX)) ||
            (map[(TOP-blockY) + 1] & (shapes[blockType][tryRotate][1] >> tryBlockX)) ||
            (map[(TOP-blockY) + 2] & (shapes[blockType][tryRotate][2] >> tryBlockX)) ||
            (map[(TOP-blockY) + 3] & (shapes[blockType][tryRotate][3] >> tryBlockX)))
        begin
            nextRotate <= rotate;
            nextBlockX <= blockX;
        end
        else begin
            nextRotate <= tryRotate;
            nextBlockX <= tryBlockX;
        end
    end

    // final check
    always@(posedge refresh)
    if(CLR)begin
        for (i=0; i<8; i=i+1)
            map[i] <= 0;
        for (i = 0; i<8; i=i+1)
            display[i] <= 0;
        nextScene <= 1;
    end
    else if(controller==3)
    case (scene)
        0: begin
            animeCount <= animeCount + 1;
            if(animeCount==0)
            begin
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
        end
        1: begin
            if(rightAction||leftAction||rotateAction)
                nextScene <= 3;
        end
        3: begin
            blockType <= random % 7;
            //blockType <= 1;
            rotate <= random % 4;
            blockX <= random % 5;
            //nextBlockY <= (TOP + shapesH[1][random % 4]+1);
            blockY <= (TOP + shapesH[random % 7][random % 4]+1);
            nextScene <= 4;
        end
        4: begin // falling
            blockY <= nextBlockY;
            blockX <= nextBlockX;
            rotate <= nextRotate;
            // blockX <= blockX;
            // rotate <= rotate;
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
                if(blockY >= TOP)
                    nextScene <= 0;
                else
                    nextScene <= 5;
            end
            else
            begin
                // erase
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
            if(map[7] == 8'b11111111)
                for(i = 7; i > 0; i = i-1)
                    if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            else if(map[6] == 8'b11111111)
                for(i = 6; i > 0; i = i-1)
                    if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            else if(map[5] == 8'b11111111)
                for(i = 5; i > 0; i = i-1)
                    if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            else if(map[4] == 8'b11111111)
                for(i = 4; i > 0; i = i-1)
                    if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            else if(map[3] == 8'b11111111)
                for(i = 3; i > 0; i = i-1)
                    if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            else if(map[2] == 8'b11111111)
                for(i = 2; i > 0; i = i-1)
                    if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            else if(map[1] == 8'b11111111)
                for(i = 1; i > 0; i = i-1)
                    if(i > 0)
                            map[i] <= map[i-1];
                        else
                            map[i] <= 0;
            
            
            for(i = 7; i > 0; i = i-1)
                if(i <= (TOP - blockY) + shapesH[blockType][rotate]-2);
            else nextScene <= 3;
            for (i = 0; i<8; i=i+1)
                display[i] <= map[i];
        end
    endcase

    //  round
    always@(posedge timer2)
        nextRound <= ~round;
    
    always@(posedge refresh)
    if(controller==4)begin
        if(nextRound!=round)
        begin
            round <= nextRound;
            nextBlockY <= blockY - 1;
            scene <= nextScene;
        end
        else if(!downAction && downNext)
        begin
            nextBlockY <= blockY - 1;
            scene <= nextScene;
        end
    end

    // display
    always@(posedge refresh)
    if(controller==4)
    begin
        rightAction <= rightNext;
        leftAction <= leftNext;
        rotateAction <= rotateNext;
        downAction <= downNext;
        COMM <= 4'b1111;
    end
    else if(controller>=5 && controller<13)
    begin
        DATA_R <= {
            ~display[7][controller-5],
            ~display[6][controller-5],
            ~display[5][controller-5],
            ~display[4][controller-5],
            ~display[3][controller-5],
            ~display[2][controller-5],
            ~display[1][controller-5],
            ~display[0][controller-5],
        };
        COMM <= {COMM[3] ,COMM[2:0]+ 1'b1};
        debugger <= 1;
    end
    else if(controller==13)
        COMM <= 4'b0000;
    
endmodule

// 0.5s , 2hz
module Timer2(input CLK, output reg CLKout);
	reg [24:0] timer=0;
	always @(posedge CLK)
	begin
		if(timer > 25000000/2)
		begin
			timer <= 0;
			CLKout <= ~CLKout;
		end
		else
			timer <= timer + 1;
	end
endmodule

// 0.04s, faster timer
module Timer25(input CLK, output reg CLKout);
	reg [24:0] timer=0;
	always @(posedge CLK)
	begin
		if(timer > 25000000/250)
		begin
			timer <= 0;
			CLKout <= ~CLKout;
		end
		else
			timer <= timer + 1;
	end
endmodule

// refresh
module TimerRefresh(input CLK, output reg CLKout);
	reg [24:0] timer=0;
	always @(posedge CLK)
	begin
		if(timer > 25000000/5000)
		begin
			timer <= 0;
			CLKout <= ~CLKout;
		end
		else
			timer <= timer + 1;
	end
endmodule