const motionAttendance = artifacts.require('MotionAttendance');
const motionRecords = artifacts.require('MotionRecords');

contract('MotionAttendance', () => {
    it('should create a motion with 3 attendees', async () => {
        const motionAttendanceInstance = await motionAttendance.deployed();
        await motionAttendanceInstance.addAttendee(web3.utils.asciiToHex("testMotion"), 0, 0, 0, web3.utils.asciiToHex("Spiderman"), 0);
        await motionAttendanceInstance.addAttendee(web3.utils.asciiToHex("testMotion"), 1, 1, 0, web3.utils.asciiToHex("Ironman"), 0);
        await motionAttendanceInstance.addAttendee(web3.utils.asciiToHex("testMotion"), 2, 3, 0, web3.utils.asciiToHex("Antman"), 0);

        const attendees = await motionAttendanceInstance.getAttendance(web3.utils.asciiToHex("testMotion"));
        let [voteDisposition, energyLevel, mediaUsed, callsign, intent] = await motionAttendanceInstance.getAttendee(web3.utils.asciiToHex("testMotion"), 0);

        assert.equal(attendees, 3, 'Total attendees not 3');

        // Cannot compare bytes32..??
        //var callsignBN = new web3.utils.BN(callsign);
        //var actualCallsignBN = new web3.utils.BN(web3.utils.asciiToHex("Spiderman"));
        //assert.equal(web3.utils.asciiToHex(callsign), 'Spiderman', 'first attendee callsign not Spiderman.');
        assert.equal(energyLevel, 0, 'first attendee energy level not zero');
    });
});

contract('MotionRecords', () => {
    it('should create a motion named voting', async () => {
        const motionRecordsInstance = await motionRecords.deployed();
        await motionRecordsInstance.createMotion(web3.utils.asciiToHex('voting'));

        let [ motionName
            , yesCount
            , noCount
            , abstainCount
            , passionLevel
            , engageLevel
            , activeLevel
            , confusedLevel
            , uncaringLevel
            , recordings] = await motionRecordsInstance.getMotionInfo(web3.utils.asciiToHex('voting'));

        assert.equal(yesCount, 0, 'Yes count not zero');
    });
});