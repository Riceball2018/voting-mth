pragma solidity ^0.8.0;

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

    address public chairperson;

    mapping(bytes32 => Motion) public motions;

    // Chairperson has to create the motion
    constructor(bytes32 motionName) {
        chairperson = msg.sender;
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
        require(msg.sender == chairperson, "Only chairperson can bulk update votes");
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