const db = require('../Config/db');

class EventAttendanceService {
  // Verify the attendance code
  static async verifyAttendanceCode(code) {
    try {
      const query = 'SELECT eventID FROM attendanceCode WHERE code = ?';
      const [rows] = await db.query(query, [code]);

      if (rows.length > 0) {
        return { eventID: rows[0].eventID }; // Return eventID 
      } else {
        return null;
      }
    } catch (err) {
      throw err;
    }
  }

  // Get userID by student number
  static async getUserIDByStudentN(studentN) {
    try {
      const query = 'SELECT userID FROM user WHERE studentN = ?';
      const [rows] = await db.query(query, [studentN]);

      if (rows.length > 0) {
        return rows[0].userID; // Return userID
      } else {
        return null;
      }
    } catch (err) {
      throw err;
    }
  }

  // Record attendance
  static async recordAttendance(eventID, userID) {
    try {
      // Ensure the eventID and userID exist before inserting
      const eventExists = await db.query('SELECT 1 FROM event WHERE eventID = ?', [eventID]);
      const userExists = await db.query('SELECT 1 FROM user WHERE userID = ?', [userID]);

      if (eventExists[0].length === 0 || userExists[0].length === 0) {
        throw new Error('Invalid eventID or userID');
      }

      const query = 'INSERT INTO eventAttendance (eventID, memberID) VALUES (?, ?)';
      await db.query(query, [eventID, userID]);
    } catch (err) {
      throw err;
    }
  }
}

module.exports = EventAttendanceService;
