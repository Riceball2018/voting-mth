pragma solidity ^0.8.0;

contract MotionAttendance {
    struct Voter {
        bool hasVoted;
        uint voteDisposition;
        uint energyLevel;
        // add more information about the voter
        // real name
        // address. etc.
    }

    struct Attendance {
        Voter[] voters;
    }

    address public chairperson;
    mapping(bytes32 => Attendance) attendances;

    // Chairperson has to create the motion
    constructor() {
        chairperson = msg.sender;
    }

    function populateVoters(bytes32 motionName, Voter[] memory voters) public {
        attendances[motionName].voters = voters;
    }

    function getVoters(bytes32 motionName) public view returns(Attendance memory) {
        return attendances[motionName];
    }
}