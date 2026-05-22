// SHREE RADHE
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract pollingSystem{
struct poll {
string title;
string[] options;
uint256 endTime ;
uint256[] voteCounts;
}
poll[] public polls;
mapping(uint256 => mapping (address => bool)) public hasvoted;
function createPoll(
string memory _title,
string[] memory _options,
uint256 _duration
)
public{
    require(_options.length >= 2,"at least 2 options present in the poll");
    uint256[] memory initialvotes = new uint256[](_options.length);
    polls.push(poll({
        title: _title,options: _options,endTime : block.timestamp + _duration,
        voteCounts:initialvotes}));
    }
    function pollCount() public view returns (uint256) {
        return polls.length;
}
function vote(uint256 _pollID,uint256 _optionIndex) public {
    require(_pollID < polls.length, "this pollID doesn't exist!");
    poll storage currentPoll = polls[_pollID];
    require(block.timestamp < currentPoll.endTime, "sorry, the deadline is finished");
    require(!hasvoted[_pollID][msg.sender], "you have already voted");
    require(_optionIndex < currentPoll.options.length, "you choose wrong option");
    hasvoted[_pollID][msg.sender] = true;
    currentPoll.voteCounts[_optionIndex] += 1;
} 
function Winner(uint256 _pollID) public view returns (string memory winningOptionText, uint256 highestVotes) {
    require(_pollID < polls.length, "This poll doesn't exit");
    poll storage currentPoll = polls[_pollID];
    require(block.timestamp >= currentPoll.endTime, "Voting is not complete yet , so can't see winner");
    uint256 optionsCount = currentPoll.options.length;
    require(optionsCount > 0, "There is no options in the poll");
    uint256 winningIndex = 0;
    highestVotes = currentPoll.voteCounts[0];
    for (uint256 i = 1; i < optionsCount; i++) {
            if (currentPoll.voteCounts[i] > highestVotes) {
                highestVotes = currentPoll.voteCounts[i];
                winningIndex = i;
            }
        }
        winningOptionText = currentPoll.options[winningIndex];
        
}
}