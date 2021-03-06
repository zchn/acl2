// VL 2014 -- Verilog Toolkit, 2014 Edition
// Copyright (C) 2008-2015 Centaur Technology
//
// Contact:
//   Centaur Technology Formal Verification Group
//   7600-C N. Capital of Texas Highway, Suite 300, Austin, TX 78731, USA.
//   http://www.centtech.com/
//
// License: (An MIT/X11-style license)
//
//   Permission is hereby granted, free of charge, to any person obtaining a
//   copy of this software and associated documentation files (the "Software"),
//   to deal in the Software without restriction, including without limitation
//   the rights to use, copy, modify, merge, publish, distribute, sublicense,
//   and/or sell copies of the Software, and to permit persons to whom the
//   Software is furnished to do so, subject to the following conditions:
//
//   The above copyright notice and this permission notice shall be included in
//   all copies or substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//   DEALINGS IN THE SOFTWARE.
//
// Original author: Jared Davis <jared@centtech.com>

//`ifdef SYSTEM_VERILOG_MODE

module dut (o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10,
            a, n1, n2);

  parameter size = 1;
  wire make_size_matter = size;

  output [40:0] o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10;
  input [3:0]  a, n1, n2;

  wire [1+$clog2( 0):0]  o0_temp = -1; assign  o0 = {n1, o0_temp,n2};
  wire [1+$clog2( 1):0]  o1_temp = -1; assign  o1 = {n1, o1_temp,n2};
  wire [1+$clog2( 2):0]  o2_temp = -1; assign  o2 = {n1, o2_temp,n2};
  wire [1+$clog2( 3):0]  o3_temp = -1; assign  o3 = {n1, o3_temp,n2};
  wire [1+$clog2( 4):0]  o4_temp = -1; assign  o4 = {n1, o4_temp,n2};
  wire [1+$clog2( 5):0]  o5_temp = -1; assign  o5 = {n1, o5_temp,n2};
  wire [1+$clog2( 6):0]  o6_temp = -1; assign  o6 = {n1, o6_temp,n2};
  wire [1+$clog2( 7):0]  o7_temp = -1; assign  o7 = {n1, o7_temp,n2};
  wire [1+$clog2( 8):0]  o8_temp = -1; assign  o8 = {n1, o8_temp,n2};
  wire [1+$clog2( 9):0]  o9_temp = -1; assign  o9 = {n1, o9_temp,n2};
  wire [1+$clog2(10):0] o10_temp = -1; assign o10 = {n1,o10_temp,n2};


  initial begin
    #10;

    $display(" o0_temp is %b", o0_temp);  $display(" o0 = %b",  o0);
    $display(" o1_temp is %b", o1_temp);  $display(" o1 = %b",  o1);
    $display(" o2_temp is %b", o2_temp);  $display(" o2 = %b",  o2);
    $display(" o3_temp is %b", o3_temp);  $display(" o3 = %b",  o3);
    $display(" o4_temp is %b", o4_temp);  $display(" o4 = %b",  o4);
    $display(" o5_temp is %b", o5_temp);  $display(" o5 = %b",  o5);
    $display(" o6_temp is %b", o6_temp);  $display(" o6 = %b",  o6);
    $display(" o7_temp is %b", o7_temp);  $display(" o7 = %b",  o7);
    $display(" o8_temp is %b", o8_temp);  $display(" o8 = %b",  o8);
    $display(" o9_temp is %b", o9_temp);  $display(" o9 = %b",  o9);
    $display("o10_temp is %b", o10_temp); $display("o10 = %b", o10);

  end


endmodule


/*+VL

module make_tests () ;

   wire [3:0] a;

   dut #(1) inst (a, a, a, a, a, a, a, a);

endmodule

*/


//`endif
