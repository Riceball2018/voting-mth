pragma solidity ^0.8.0;

contract MotionAttendance {
    struct Attendee {
        bool hasVoted;
        uint voteDisposition; // Yes/no/abstain
        uint energyLevel; // how supportive is said attendee perceived to the issue at hand
        uint mediaUsed; // device type used to attend:   0 means in-person; 1 means laptop; 2 means AR; 3 means VR
        bytes32 callsign;
        uint intention; // scale of 1 to 10: 10 is highest, attendee’s intention to push topic forward
        bytes32 emailAddress;
        
        // add more information
        // real name
        // address. etc.
    }

    struct Attendance {
        Attendee[] attendees;
    }

    address public chairperson;
    mapping(bytes32 => Attendance) attendances;

    // Chairperson has to create the motion
    constructor() {
        chairperson = msg.sender;
    }

    function populateAttendees(bytes32 motionName, Attendee[] memory attendees) public {
        attendances[motionName].attendees = attendees;
    }

    function getAttendees(bytes32 motionName) public view returns(Attendance memory) {
        return attendances[motionName];
    }
}