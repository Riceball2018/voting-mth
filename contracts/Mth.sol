pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MotionAttendance {
    struct Attendee {
        uint voteDisposition; // Yes/no/abstain
        uint energyLevel; // how supportive is said attendee perceived to the issue at hand
        uint mediaUsed; // device type used to attend:   0 means in-person; 1 means laptop; 2 means AR; 3 means VR
        bytes32 callsign;
        uint intention; // scale of 1 to 10: 10 is highest, attendee’s intention to push topic forward
    }

    struct Attendance {
        Attendee[] attendees;
    }

    event AttendeeAdded(bytes32 motionName, uint voteDisposition, uint energyLevel, uint mediaUsed, bytes32 callsign, uint intent);
    address public chairperson;
    mapping(bytes32 => Attendance) attendances;

    // Chairperson has to create the motion
    constructor() {
        chairperson = msg.sender;
    }

    function addAttendee(bytes32 motionName, uint voteDisposition, uint energyLevel, uint mediaUsed, bytes32 callsign, uint intent) public {
        Attendee memory attendee;
        attendee.voteDisposition = voteDisposition;
        attendee.energyLevel = energyLevel;
        attendee.mediaUsed = mediaUsed;
        attendee.callsign = callsign;
        attendee.intention = intent;
        attendances[motionName].attendees.push(attendee);
        emit AttendeeAdded(motionName, voteDisposition, energyLevel, mediaUsed, callsign, intent);
    }

    function getAttendance(bytes32 motionName) public view returns (uint) {
        return attendances[motionName].attendees.length;
    }

    function getAttendee(bytes32 motionName, uint index) public view returns (Attendee memory) {
        return attendances[motionName].attendees[index];
    }
}

contract MotionRecords {
    // meeting metadata
    struct Motion {
        bytes32 name;
        uint yesCount;
        uint noCount;
        uint abstainCount;
        uint passionLevel;
        uint engageLevel;
        uint activeLevel;
        uint confusedLevel;
        uint uncaringLevel;
        // TODO: add video per breakout room
        bytes32[] motionRecordings; // IPFS hash for breakout room recordings
    }

    mapping(bytes32 => Motion) public motions;

    // Chairperson has to create the motion
    function createMotion(bytes32 motionName) public {
        Motion memory motion;
        motion.name = motionName;

        motions[motionName] = motion;
    }

    function updateMotionRecord( bytes32 motionName
                               , uint yesCount
                               , uint noCount
                               , uint abstainCount
                               , uint passionLevel
                               , uint engageLevel
                               , uint activeLevel
                               , uint confusedLevel
                               , uint uncaringLevel
                               , bytes32[] memory recordings
                               ) public {
        motions[motionName].yesCount = yesCount;
        motions[motionName].noCount = noCount;
        motions[motionName].abstainCount = abstainCount;
        motions[motionName].passionLevel = passionLevel;
        motions[motionName].engageLevel = engageLevel;
        motions[motionName].activeLevel = activeLevel;
        motions[motionName].confusedLevel = confusedLevel;
        motions[motionName].uncaringLevel = uncaringLevel;
        motions[motionName].motionRecordings = recordings;
    }

    function getMotionInfo(bytes32 motionName) public view returns (Motion memory) {
        return motions[motionName];
    }
}

contract CityVoucher is ERC721URIStorage {
    uint256 private _tokenIds;

    constructor() ERC721("CityVoucher", "CV") {}

    function awardItem(address player, string memory tokenURI) public returns (uint256) {
        _tokenIds++;

        uint256 newItemId = _tokenIds;
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}