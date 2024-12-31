module tb_round_robin_arbiter_fixed_time_slices;

    // Inputs
    reg clk;
    reg rst_n;
    reg [3:0] REQ;
    reg [3:0] empty_queue;
    reg ACK;

    // Outputs
    wire [3:0] GNT;

    // Instantiate the arbiter module
    round_robin_arbiter_fixed_time_slices uut (
        .clk(clk),
        .rst_n(rst_n),
        .REQ(REQ),
        .empty_queue(empty_queue),
        .ACK(ACK),
        .GNT(GNT)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        rst_n = 1;

        // Initialize inputs
        REQ = 4'b0000;
        empty_queue = 4'b0000;
        ACK = 0;

        // Test Case 1: No requests
        #20;
        REQ = 4'b0000;
        empty_queue = 4'b0000;
        #20;

        // Test Case 2: Single request from REQ[0]
        REQ = 4'b0001;
        #20;
        ACK = 1; #10; ACK = 0; // Acknowledge grant
        #20;

        // Test Case 3: Multiple requests (REQ[1] and REQ[2])
        REQ = 4'b0110;
        #20;
        ACK = 1; #10; ACK = 0; // Acknowledge grant
        #20;

        // Test Case 4: Round-robin priority cycling with all requesters
        REQ = 4'b1111; // All requesters active
        #20;
        ACK = 1; #10; ACK = 0; // Acknowledge grant
        #20;

        // Test Case 5: Some queues are empty
        //REQ = 4'b1111;
        //empty_queue = 4'b0101; // Queues for requester 0 and 2 are empty
        //#20;
       // ACK = 1; #10; ACK = 0; // Acknowledge grant
        //#20;

        /// Test Case 6: All queues are empty
       // REQ = 4'b1111;
        //empty_queue = 4'b1111; // All queues empty, should not grant
        //#20;

        /// Test Case 7: Sequential grants in round-robin order
        //REQ = 4'b1111;
       // empty_queue = 4'b0000; // No empty queues
        //#20;
        
        /// Cycle through requests
        //repeat (4) begin
        //    ACK = 1;
        //    #10 ACK = 0;
        //    #20;
      end

        // Finish the simulation
        //$stop;

endmodule

