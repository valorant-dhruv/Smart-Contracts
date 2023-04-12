//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

//In this smart contract we are going to create a small merkle tree of four transactions
//And we are also going to get the root of that merkle tree
contract MerkleTree{

    //This is the dynamic bytes array that stores all the hashes of the merkle tree
    //The below is a sample merkle tree
    //Here the indexing starts from the bottom up that is the hash of transaction A is at index 0 in hashes array
    //The hash of the merkle root is at index length - 1
    //ABCD
    //AB CD
    //A B C D
    bytes32[] public hashes;

    string[2] public transactions=[
        "T1","T2"
    ];

    //Now we are creating the merkle tree
    function createmerkletree() public{
        for(uint i = 0; i < transactions.length; i++) {
            hashes.push(keccak256(abi.encodePacked(transactions[i])));
        }

        //Now that all the leaf node transaction hashes are added to the array we need to add the upper elements
        uint n = transactions.length;
        uint options=0;
        while(n > 0)
        {
            for(uint i=0;i<n-1;i+=2)
            {
               hashes.push(keccak256(abi.encodePacked(hashes[options+i],hashes[options+i+1])));
            }

            options+=n;
            n=n/2;

        }    
    }

    //This is the function that returns the hash array
    function gethasharray() public view returns(bytes32[] memory )
    {
        return hashes;
    }

    //This function returns the length of the hashes array
    function getlength() public view returns(uint)
    {
        return hashes.length;
    }
}

//The hash of transaction 1= 0x1d8f9b6eeff5bce8244a794936af0028b866d4a2270dff5f43a57b116d4f5603
//The hash of transaction 2= 0x88f0c4bde9f065ca2ccdd463ec1b07879cc5e1080407afe6179ab91e8141eab2
//The hash of merkle root= 0x1d8f9b6eeff5bce8244a794936af0028b866d4a2270dff5f43a57b116d4f5603


//Now this is the smart contract for the Merkle proof to indicate whether the given transaction is present inside the tree
//or not

contract Merkleproof{
    //Inside the merkleproof function we need to pass the proof array, the hash of the leaf node to search for and the 
    //root node to verify it

    // bytes32 public leaf=0x1d8f9b6eeff5bce8244a794936af0028b866d4a2270dff5f43a57b116d4f5603;
    // bytes32 public root= 0x1d8f9b6eeff5bce8244a794936af0028b866d4a2270dff5f43a57b116d4f5603;

    // bytes32[] proof=['']

     function verify(
        bytes32[] memory proof,
        bytes32 root,
        bytes32 leaf,
        uint index
    ) public pure returns (bool) {
        bytes32 hash = leaf;

        for (uint i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proofElement));
            } else {
                hash = keccak256(abi.encodePacked(proofElement, hash));
            }

            index = index / 2;
        }

        return hash == root;
    }
}