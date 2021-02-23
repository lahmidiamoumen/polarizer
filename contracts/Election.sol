// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details


contract Election{

    struct Voter{
        bool voted;
        uint indexVoter;
        uint weight;
    }

    struct Condidate{
        string name;
        uint voteCount;
    }
    string name;
    address public owner;
    mapping(address => Voter) public voters;
    Condidate[] public condidates;
    uint public auctionEnd;

    event Voted(string _message);

    constructor (string memory _name, uint duration,string memory con1, string memory con2) public {
        owner = msg.sender;
        name = _name;
        auctionEnd =    block.timestamp + (duration * 1 minutes);

        condidates.push(Condidate(con1,0));
        condidates.push(Condidate(con2,0));
    }

    function authorize(address voter) public {
        // the sender is the owner
        require(msg.sender == owner);
        require(!voters[voter].voted);

        voters[voter].weight = 1;
    }

    function vote(uint voteIndex) public {
        // the duration of vote has't already pass
        require(block.timestamp < auctionEnd);
        // the sender has't voted before
        require(!voters[msg.sender].voted);
        voters[msg.sender].voted = true;
        condidates[voteIndex].voteCount += 1; //voters[msg.sender].weight;
        
        emit Voted("Data stored successfully!");
    }


}
