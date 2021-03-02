// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;



/// @title A title that should describe the contract/interface
/// @author L.Moumen
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details


contract Election{

    struct Voter{
        uint weight;
        mapping(uint => uint) votedChoice;  // index of the voted proposal choice
        mapping(uint => bool) votedIndex;  // index of the voted proposal
    }

    struct Proposals{
        address creator;
        string description;
        uint256[] condidate_voteCount;
        bytes32[] condidate_name;
    }

    struct Condidate{
        bytes32 name;
        uint256 voteCount;
    }
    string name;
    address public owner;
    mapping(address => Voter) public voters;
    address[] authorized;
    Proposals[] internal proposals;
    uint public auctionEnd;



    event Voted(string _message);

    function getproposals() view external returns(Proposals[] memory){
        return proposals;
    }

    function addProposals(bytes32[] memory _condidates,string memory _description) public {
        uint256[] memory condidate_voteCount = new uint256[](_condidates.length);

        for (uint i = 0; i < _condidates.length; i++) {
            condidate_voteCount[i] = 0;
        }

        proposals.push(Proposals({
            creator: msg.sender,
            description: _description,
            condidate_voteCount: condidate_voteCount,
            condidate_name: _condidates
        }));
    }

    constructor (uint duration) public {
        owner = msg.sender;
        auctionEnd =    block.timestamp + (duration * 1 minutes);

        authorize(owner);
    }

    function authorize(address voter) public {
        // the sender is the owner
        require(msg.sender == owner);
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
        authorized.push(voter);
    }


    // view is free
    function getAuthorized() view external returns (address[] memory) {
        return authorized;
    }

    function vote(uint propIndex,uint choiceIndex) public {
        // the duration of vote has't already pass
        require(block.timestamp < auctionEnd);
        // the sender has't voted before
        require(!voters[msg.sender].votedIndex[propIndex]);
        // the sender is voitng
        voters[msg.sender].votedIndex[propIndex] = true;
        // the sender choice from a proposal
        voters[msg.sender].votedChoice[propIndex] = choiceIndex;
        // increment proposal choice!
        proposals[propIndex].condidate_voteCount[choiceIndex] += voters[msg.sender].weight;
        
        emit Voted("Voted successfully!");
    }


}
