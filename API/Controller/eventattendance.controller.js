const AttendanceService = require('../Services/eventattendance.service');

exports.verifyAttendanceCode = async (req, res, next) => {
  const { code } = req.body;
  try {
    const result = await AttendanceService.verifyAttendanceCode(code);
    if (result) {
      res.status(200).json(result);
    } else {
      res.status(404).json({ message: 'Invalid attendance code' });
    }
  } catch (err) {
    next(err);
  }
};

exports.recordAttendance = async (req, res, next) => {
  const { eventID, studentN } = req.body;
  try {
    if (!eventID || !studentN) {
      return res.status(400).json({ message: 'Missing required fields' });
    }
    
    // Convert studentN to userID
    const userID = await AttendanceService.getUserIDByStudentN(studentN);
    if (!userID) {
      return res.status(404).json({ message: 'Invalid student number' });
    }

    await AttendanceService.recordAttendance(eventID, userID);
    res.status(201).json({ message: 'Attendance recorded successfully' });
  } catch (err) {
    next(err);
  }
};
