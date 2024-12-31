module round_robin_arbiter(Clk, Reset, Request, Grant);
input Clk, Reset;
input [3:0] Request;
output reg [3:0] Grant;
reg [2:0] Currentstate, Nextstate;
// Flip-Flop for state transition on positive edge of the clock
always @(posedge Clk) begin
if (Reset)
Currentstate <= 0;
else
Currentstate <= Nextstate;
end
// Next State Logic with Active Request Management and Dynamic Scanning
always @(*) begin
case (Currentstate)
3'b000: begin
if (Request[0]) Nextstate = 3'b001;
else if (Request[1]) Nextstate = 3'b010;
else if (Request[2]) Nextstate = 3'b011;
else if (Request[3]) Nextstate = 3'b100;
else Nextstate = 3'b000;
end
3'b001: begin
if (Request[1]) Nextstate = 3'b010;
else if (Request[2]) Nextstate = 3'b011;
else if (Request[3]) Nextstate = 3'b100;
else if (Request[0]) Nextstate = 3'b001;
else Nextstate = 3'b000;
end
3'b010: begin
if (Request[2]) Nextstate = 3'b011;
else if (Request[3]) Nextstate = 3'b100;
else if (Request[0]) Nextstate = 3'b001;
else if (Request[1]) Nextstate = 3'b010;
else Nextstate = 3'b000;
end
3'b011: begin
if (Request[3]) Nextstate = 3'b100;
else if (Request[0]) Nextstate = 3'b001;
else if (Request[1]) Nextstate = 3'b010;
else if (Request[2]) Nextstate = 3'b011;
else Nextstate = 3'b000;
end
3'b100: begin
if (Request[0]) Nextstate = 3'b001;
else if (Request[1]) Nextstate = 3'b010;
else if (Request[2]) Nextstate = 3'b011;
else if (Request[3]) Nextstate = 3'b100;
else Nextstate = 3'b000;
end
default: begin
if (Request[0]) Nextstate = 3'b001;
else if (Request[1]) Nextstate = 3'b010;
else if (Request[2]) Nextstate = 3'b011;
else if (Request[3]) Nextstate = 3'b100;
else Nextstate = 3'b000;
end
endcase
end
// Output Logic for Grant signals based on the current state
always @(*) begin
case (Currentstate)
3'b001: Grant = 4'b0001;
3'b010: Grant = 4'b0010;
3'b011: Grant = 4'b0100;
3'b100: Grant = 4'b1000;
3'b000: Grant = 4'b0000;
default: Grant = 4'b0000;
endcase
end
endmodule