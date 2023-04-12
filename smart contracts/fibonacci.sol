// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Fibonacci {
  function fib(uint n) public pure returns(uint)
  {
    require(n>=0, "You cannot have a negative number as n");

    //The normal flow of the function continues
    //Declare some local variables
    uint a=0;
    uint b=1;

    //If the nth number is the first or the second number than in that case just return the value of n
    if(n==0 || n==1)
    {
      return n;
    }
    else{
      //Now we need to loop through n-1 times to find the value of nth fibonacci number
      uint c;
      for(uint i=0;i<n-1;i++)
      {
        c=a+b;
        a=b;
        b=c;
      }

      return c;
    }

  }
}