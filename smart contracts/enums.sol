//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract enums{
    //Creating an enum for voters
    enum  voters{not_voted,voted}

    voters public dhruv=voters.not_voted;
    voters public dev=voters.voted;

    string public dhruvvoted;

    function check() public returns(string memory)
    {
        if(dhruv==voters.not_voted)
        {
            dhruvvoted="Dhruv has not voted";
        }

        else{
            dhruvvoted="Dhruv has voted";
        }

        return dhruvvoted;
    }
}