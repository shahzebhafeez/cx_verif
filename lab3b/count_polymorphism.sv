virtual class counter;

    int count; 
    int max;
    int min;

    // Constructor
    function new(int counter = 0,int default_min,int default_max);
        this.count = counter;
	this.min = default_min;
	this.max = default_max;
	check_limit(default_min,default_max);
	check_set(counter);
    endfunction

    // Load a value
    function void load(int mycount);
        this.count = mycount;
	check_set(mycount);
    endfunction

    // Return the current count
    function int getCount();
        return this.count;
    endfunction

    function void check_limit(int num1,int num2);
	if(num1>num2) begin
		this.max=num1;
		this.min=num2;
	end
	else begin
		this.max=num2;
		this.min=num1;
	end
    endfunction
 
    function void check_set(int count);
	// limit check count arg
	if(count < this.min || count > this.max) begin
		this.count = min;
		$display("the set count %d is outside min limit %d and max limit %d",count,this.min,this.max);
	end
	else begin
		this.count = count;
	end
	
    endfunction
	
    // next method
    virtual function void next();
	$display("This is counter class");
    endfunction 

endclass


// Subclass: Upcounter
class upcounter extends counter;
    bit carry;
    static int instance_count = 0;
    function new(int count = 0,bit default_carry=0);
        super.new(count,0,100);
	this.carry=default_carry;
	instance_count++;
    endfunction

    function void next();
	if (count >= this.max) begin
		this.count = this.min;
		this.carry=1'b1;
	end
	    else begin
		this.count++;
		this.carry=1'b0;
	    end

    $display("The upcount is: %0d", this.count);
    endfunction
    static function int get_instance();
	return instance_count;
    endfunction

endclass


// Subclass: Downcounter
class downcounter extends counter;
    bit borrow;
    static int instance_count=0;

    function new(int count = 0,bit default_borrow=0);
        super.new(count,0,100);
	this.borrow = default_borrow;
	instance_count++;
    endfunction

    function void next();
	 if (count <= this.min) begin
            this.count = this.max;
	    this.borrow = 1'b1;
	 end
	 else begin
	    this.count--;
	    this.borrow = 1'b0;
	 end
	    $display("The downcount is: %0d", this.count);
    endfunction
    static function int get_instance();
	return instance_count;


    endfunction

endclass


// Timer class: child of upcounter
class timer extends upcounter;

    upcounter hours;
    upcounter minutes;
    upcounter seconds;

    // Constructor
    function new(int h = 0, int m = 0, int s = 0);

        // Initialize inherited upcounter (not used for clock time)
        super.new(0);

        // Create separate counters with their own limits
        hours   = new(h);
        minutes = new(m);
        seconds = new(s);

        // Configure clock limits
        hours.check_limit(0, 23);
        minutes.check_limit(0, 59);
        seconds.check_limit(0, 59);

        // Validate initial values
        hours.check_set(h);
        minutes.check_set(m);
        seconds.check_set(s);

    endfunction


    // Load a new time
    function void load(int my_h, int my_m, int my_s);

        hours.check_set(my_h);
        minutes.check_set(my_m);
        seconds.check_set(my_s);

    endfunction


    // Display current time
    function void show_val();

        $display("Time = %02d:%02d:%02d",
                 hours.getCount(),
                 minutes.getCount(),
                 seconds.getCount());

    endfunction


    // Advance timer by one second
    function void next();

        // Increment seconds
        seconds.next();

        // If seconds rolled over, increment minutes
        if (seconds.carry == 1'b1) begin

            minutes.next();

            // If minutes rolled over, increment hours
            if (minutes.carry == 1'b1) begin

                hours.next();

            end

        end

        show_val();

    endfunction

endclass
