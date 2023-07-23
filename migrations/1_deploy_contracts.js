var MotionAttendance = artifacts.require("MotionAttendance");
var MotionRecords = artifacts.require("MotionRecords");
var CityVoucher = artifacts.require("CityVoucher");

module.exports = function(deployer) {
  deployer.deploy(MotionAttendance);
  deployer.deploy(MotionRecords);
  deployer.deploy(CityVoucher);
};
