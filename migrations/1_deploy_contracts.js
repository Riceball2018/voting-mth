var MotionAttendance = artifacts.require("MotionAttendance");
var MotionRecords = artifacts.require("MotionRecords");

module.exports = function(deployer) {
  deployer.deploy(MotionAttendance);
  deployer.deploy(MotionRecords);
};
