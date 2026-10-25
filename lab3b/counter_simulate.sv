module tb(counter_interf.tb vif);

    /*counter c1; 
    upcounter c2,c4,c6;
    downcounter c3,c7;

    */
    // base class handle
    counter c0;
    // child class handle
    upcounter i0;
    upcounter i1;
    integer i;

    initial begin
        // Test 1: Base counter
        /*c1 = new();
        vif.count_value = 0;

        @(negedge vif.clk);

        c1.load(10);
        vif.count_value = c1.getCount();
        $display("The count is: %0d", c1.getCount());

        #5;
	*/
        // Test 2: Constructor
        /*c1 = new();
        vif.count_value = c1.getCount();
        $display("The count is: %0d", c1.getCount());

        #5;
	*/
        // Test 3: Upcounter: 0, 1, 2, ... 100
        /*$display("\n--- Upcounter Test ---");

        c2 = new(); // 0 onward
	vif.carry=0;
   	vif.borrow = 0;
 	vif.count_value=c2.getCount();

        for (i = 0; i <= 200; i++) begin
 	     @(negedge vif.clk);
            	    vif.count_value = c2.getCount();
		    vif.carry=c2.carry;
		    vif.borrow = 0;
		    $display("Count = %0d, carry = %0b",vif.count_value, vif.carry);

		 if (i < 200)
		     c2.next();
        end

        #5;
	*/
        // Test 4: Downcounter: 100, 99, ... 3, 2, 1
        /*$display("\n--- Downcounter Test ---");

        c3 = new(100); // 100 downwards
	vif.carry=0;
   	vif.borrow = 0;
 	vif.count_value=c3.getCount();

        for (i = 200; i >= 1; i--) begin
	    @(negedge vif.clk);
		    vif.count_value = c3.getCount();
		    vif.carry=0;
		    vif.borrow = c3.borrow;
		    $display("Count = %0d, borrow = %0b",vif.count_value, vif.borrow);

		    if (i > 1)
		        c3.next();
        end
        $display("\nAll counter tests completed.");
	
	*/

	// static up count test
	/*c2 = new(10);
	c4 = new(20);
	c6 = new(30);

	$display("up count instances : %d",upcounter::get_instance());
	// static down count test
	c3 = new(10);
	c7 = new(20);

	$display("down count instances : %d",downcounter::get_instance());
	*/

	// upcounter instnace 
	i0 = new(0);
        c0 = i0;
	// copy i0 upcounter instance from counter handle to new upcounter handle
	$cast(i1,c0);
	i1.next();
	$display("child class instance assigned to base class handle : %d",c0.getCount());
	$finish;



    end

endmodule
