module t_tetris;
	wire [7:0] map0,map1,map2,map3,map4,map5,map6,map7;
	wire [7:0] t_debug1,debugger;
	reg t_CLK, t_CLR, t_right, t_left, t_rotating;
	tetris M1(map0,map1,map2,map3,map4,map5,map6,map7,t_debug1,debugger,t_CLK, t_CLR, t_right, t_left, t_rotating);
	
	integer times;
	
	initial #5000 $finish;
	initial begin
		t_CLK = 0;
		forever #5 t_CLK = ~t_CLK;
	end
	initial begin
		#40 t_right = 0; t_left = 0; t_rotating = 0;
		#40 t_right = 1;
		#40 t_right = 0;
		times=0;
		repeat(110) #40
			begin
				times=times+1;
				// square test
				/*
				if(times==1) t_right = 1;
				if(times==10) t_right = 0;
				if(times==19) t_right = 1;
				if(times==20) t_right = 0;
				if(times==50) t_right = 1;
				if(times==53) t_right = 0;
				*/
				
				if(times==1) t_rotating = 1;
				if(times==4) t_right = 1;
				if(times==7) t_right = 0;
				if(times==6) t_rotating = 0;
				
				$display("%d| scene=%d debugger=%d(%b)\n|%b|\n|%b|\n|%b|\n|%b|\n|%b|\n|%b|\n|%b|\n|%b|\n|TTTTTTTT|\n", times,t_debug1,debugger,debugger,map0,map1,map2,map3,map4,map5,map6,map7);
			end
			
	end
endmodule