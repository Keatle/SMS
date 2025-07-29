const db = require('../Config/db');

class MinutesService {

    // Retrieve user ID based on student number
    static async getUserIdByStudentNumber(studentN) {
        try {
            const query = 'SELECT userID FROM user WHERE studentN = ?';
            const [rows, _] = await db.query(query, [studentN]);
            return rows.length ? rows[0].userID : null;
        } catch (err) {
            throw err;
        }
    }

    // Retrieve all meeting minutes for societies the user is a part of
    static async getMinutesByUserId(userId) {
        try {
            const query = `
                SELECT m.*, s.societyName 
                FROM minutes m
                JOIN societyMember sm ON m.societyID = sm.societyID
                JOIN society s ON m.societyID = s.societyID
                WHERE sm.userID = ?`;
            const [rows, _] = await db.query(query, [userId]);
            return rows;
        } catch (err) {
            throw err;
        }
    }

    // Get all minutes
    static async getMinutes() {
        try {
            const query = 'SELECT * FROM minutes';
            const [rows, _fields] = await db.query(query);
            return rows;
        } catch (err) {
            throw err;
        }
    }

    // Get a single minute by ID
    static async getMinuteById(minutesID) {
        try {
            const query = 'SELECT * FROM minutes WHERE minutesID = ?';
            const [rows, _fields] = await db.query(query, [minutesID]);
            return rows[0];
        } catch (err) {
            throw err;
        }
    }
}

module.exports = MinutesService;
