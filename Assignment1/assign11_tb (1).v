module parking_tb();
reg clk;
reg [1:0]password_input;
reg car;
reg reset;
 wire sensor_back,sensor_front;
wire [4:0]count;

parking P(clk,reset,sensor_back,sensor_front,password_input,car,count);
initial clk=0;
always #5 clk=~clk;

initial
       begin
$monitor($time,"reset=%b car=%b password_input=%b sensor_front=%b sensor_back=%b count=%d",reset,car,password_input,sensor_front,sensor_back,count);
car=1'b0;
reset=1'b1;
#15
car=1'b1;
reset=1'b0;
password_input=2'b00;      //car1

#10 password_input=2'b10;
#10 car=1'b1;              //car2
#10 password_input=2'b11;
#10 car=1'b1;              //car3
#10 password_input=2'b10;
#10  password_input=2'b11;
#10  password_input=2'b11;
#50 $finish;
	end

endmodule



module parking(clk,reset,sensor_back,sensor_front,password_input,car,count);
input clk;
input reset;
output reg sensor_back=0,sensor_front=0;
input [1:0]password_input;
input car;
parameter password_correct=2'b11;
output reg [4:0]count;

parameter IDLE=2'b00,PASSWORD=2'b01,PARK=2'b10;

reg [1:0]current_state,next_state;

always@(posedge clk)
begin
if(reset)
begin
current_state<=IDLE;
count<=5'b00000;
end
else
current_state<=next_state;
end

always@(posedge clk)
begin
    case(current_state)
    IDLE:begin
		sensor_back=1'b0;
              if(car==1'b1)
             begin
              sensor_front=1'b1;
              next_state<=PASSWORD;
               end
               else
              next_state<=IDLE;
              end

	PASSWORD: begin
		if(password_input==password_correct)
		next_state<=PARK;
		else
		next_state<=IDLE;
                end


      PARK:begin
                
             sensor_back=1'b1;
	    sensor_front=1'b0;
		count<=count+1;
		next_state<=IDLE;
             end


      default: next_state<=IDLE;

endcase
end
endmodule


