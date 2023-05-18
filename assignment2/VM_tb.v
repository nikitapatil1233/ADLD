module vending_machine_tb();

reg [2:0]a;
reg [2:0]b;
reg clk;
reg [1:0]product;
wire [3:0]change;
wire [1:0]z;

vending_machine dut(a,b,clk,product,change,z);

initial clk=0;
always #10 clk=~clk;

initial 
   	begin
	
	product =2'b10; a=3'b000; b=3'b010;
	#30
	 product = 2'b11 ; a=3'b100 ; b=3'b000;
	#60
	product = 2'b01 ; a=3'b000; b=3'b001;
	end

initial 
	begin
	$monitor("TIME:%6d, a=%d, b=%d, product= %d, change=%d, z=%d", $time, a, b, product, change, z);
	#200 $finish;
	end
endmodule





module vending_machine(a,b,clk,product,change,z);
input [2:0]a; //no. of 5 rupee coins
input [2:0]b; //no. of 10 rupee coins
//input x=4'b0101;
//input y=4'b1010;
input clk;
input [1:0]product;

output reg [3:0]change;
output reg [1:0]z; //if z==1 the product is given z==0 the product is not given;

parameter A=2'b00 ,B=2'b01 ,C=2'b10 ,D=2'b11;
reg [2:0]state, next_state;

always @(posedge clk)
begin
if(product==2'b00)
state <= A;

else if(product==2'b01)
state <= B;

else if(product==2'b10)
state <= C;

else if(product==2'b11)
state <= D;



end

always @(*)
begin
case(state)
A : begin 
	if(a==3'b001)
	begin
	z=2'b00;
	change=4'b0000;
	//next_state <= B;
	end
	
	else if(b==3'b001)
	begin
	change = 4'b0101;
	z=2'b00;
	//next_state <=B;
	end

	
    end

B : begin 
	if(a==3'b010)
	begin
	z=2'b01;
	change=4'b0000;
	//next_state <=C;
	end
	
	else if(b==3'b001)
	begin
	z=2'b01;
	change=4'b0000;
	//next_state <= C;
	end

	
    end

C : begin 
	if(a==3'b011)
	begin
	z=2'b10;
	change=4'b0000;
	//next_state <= D;
	end
	
	else if(b==3'b001)
	begin
	
	if(a==3'b001)
	begin
	z=2'b10;
	change=4'b0000;
	//next_state <= D;
	end
	end

	else if(b==3'b010)
	
	begin
	change = 4'b0101;
	z=2'b10;
	//next_state <= D;
	end
	

	
    end

D : begin 
	if(a==3'b100)
	begin
	z=2'b11;
	change=4'b0000;
	//next_state <=A ;
	end
	
	else if(b==3'b010)
	
	begin
	z=2'b11;
	change=4'b0000;
	//next_state <= A;
	end
	

	else if(b==3'b001)
	begin
	
	if(a==3'b010)
	begin
	
	z=2'b11;
	change=4'b0000;
	//next_state <= A;
	end
	end
	

	
    end

default:next_state<= A;

endcase
end 
endmodule




	          


