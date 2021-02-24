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
        bytes32 name;
        uint voteCount;
    }
    string name;
    address public owner;
    mapping(address => Voter) public voters;
    Condidate[] public condidates;
    uint public auctionEnd;

    event Voted(string _message);

    constructor (string memory _name, uint duration,bytes32[] memory con) public {
        owner = msg.sender;
        name = _name;
        auctionEnd =    block.timestamp + (duration * 1 minutes);

        for (uint i = 0; i < con.length; i++) {
            // `Proposal({...})` creates a temporary
            // Proposal object and `proposals.push(...)`
            // appends it to the end of `proposals`.
            condidates.push(Condidate({
                name: con[i],
                voteCount: 0
            }));
        }

    }

    function authorize(address voter) public {
        // the sender is the owner
        require(msg.sender == owner);
        require(!voters[voter].voted);

        voters[voter].weight = 1;
    }

    function getCondidateNames() view public returns (bytes32[] memory) {
        uint csa = getCount();
        bytes32[] memory foo = new bytes32[](csa);
        for (uint i = 0; i < condidates.length; i++) {
            foo[i] = condidates[i].name;
        }
        return foo;
    }

    function getCondidateVotes() view public returns (uint[] memory) {
        uint csa = getCount();
        uint[] memory foo = new uint[](csa);
        for (uint i = 0; i < condidates.length; i++) {
            foo[i] = condidates[i].voteCount;
        }
        return foo;
    }

    function getCount() public view returns(uint count) {
        return condidates.length;
    }

    function vote(uint voteIndex) public {
        // the duration of vote has't already pass
        require(block.timestamp < auctionEnd);
        // the sender has't voted before
        require(!voters[msg.sender].voted);
        voters[msg.sender].voted = true;
        condidates[voteIndex].voteCount += voters[msg.sender].weight;
        
        emit Voted("Voted successfully!");
    }


}
