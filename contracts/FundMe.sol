// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {

    // 代表候选人的结构体
    struct Candidate { 
        uint id; // id
        string name; // 姓名
        uint voteCount; // 候选人获得的票数
    }


    // 存储候选人信息的数组
    Candidate[] public candidates;


    mapping(string => uint) nameToId;

    // 投票截止日期时间戳
    uint public votingEndTime;

    // 用于记录是否投过票的映射
    mapping(address => bool) voters;

    // 记录总投票人数
    uint public totalVoters;

    // 合约部署者的地址
    address public owner;

    // 投票事件，记录投票人地址和候选人ID
    event VotedEvent(address indexed voter, uint indexed id);

    // 构造函数，初始化合约，设置投票截止日期和初始候选人
    constructor(uint durationInMinutes) {
        owner = msg.sender;
        votingEndTime = block.timestamp + (durationInMinutes * 1 minutes);
    }

    // 添加候选人，只能通过外部调用触发
    function addVoters(string memory name) external {
        // 只有合约部署者可以添加候选人
        require(msg.sender == owner, unicode"只有合约部署者可以添加候选人");
        candidates.push(Candidate(
            candidates.length,
            name,
            0
        ));

        nameToId[name] = candidates.length;

    }

    // 投票函数，使用本地化的提示信息
    function vote(uint sheiid) external {
        require(sheiid < candidates.length, "Invalid candidate");
        require(!voters[msg.sender], "You have already voted");

        candidates[sheiid].voteCount++;

        voters[msg.sender] = true;
        
        totalVoters++;

        emit VotedEvent(msg.sender, sheiid);

    }

    // 获取特定候选人的投票数 通过id
    function getCandidates(uint candidateId) public view returns(uint256) {
        // 检查候选人是否存在
        require(candidateId < candidates.length, 
            "Invalid candidate");

            return candidates[candidateId].voteCount;
    }

    // 获取特定候选人的投票数 通过name
    function getname(string memory name) public view returns(uint256) {
        // 检查候选人是否存在
        require(nameToId[name] < candidates.length, 
            "Invalid candidate");

            return candidates[nameToId[name]].voteCount;
    }

    // 获取候选人总数
    function getCandidateCount() 
        public view returns (uint) {
        // 返回候选人数组的长度
        return candidates.length;
    }

    // 检查投票是否已经结束
    function isVotingClosed() public view returns (bool) {
        // 检查当前时间是否超过投票截止日期
        return block.timestamp >= votingEndTime;
    }

    // 获取当前的候选人排名
    function getpaiming() public view returns(Candidate[] memory) {
        require(isVotingClosed(), "Voting is not closed yet");

        Candidate[] memory arrs = candidates;



        for(uint i = 0; i < arrs.length - 1; i++) {
            for(uint j = 0; j < arrs.length - 1 - i; j++) {

                if( arrs[j].voteCount < arrs[j + 1].voteCount ) {

                    (arrs[j], arrs[j + 1]) = (arrs[j + 1], arrs[j]);

                }

            }
        }

        return arrs;

    }

}