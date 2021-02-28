// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;



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
    Condidate[] public condidates;
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

    constructor (string memory _name, uint duration,bytes32[] memory con) public {
        owner = msg.sender;
        name = _name;
        auctionEnd =    block.timestamp + (duration * 1 minutes);

        authorize(owner);

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
        require(voters[voter].weight == 0);

        voters[voter].weight = 1;
        authorized.push(voter);
    }



    // view is free
    

    function getAuthorized() view external returns (address[] memory) {
        return authorized;
    }

    // view is free
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
