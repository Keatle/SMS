const db = require('../Config/db');

class AgendaService {

    // Retrieve user ID based on student number
    static async getUserIdByStudentNumber(studentN) {
        try {
            const query = 'SELECT userID FROM user WHERE studentN = ?';
            const [rows] = await db.query(query, [studentN]);
            return rows.length ? rows[0].userID : null;
        } catch (err) {
            throw err;
        }
    }

    // Retrieve all agendas for societies the user is a part of
    static async getAgendasByUserId(userID) {
        try {
            const query = `
                SELECT a.*, s.societyName
                FROM agenda a
                JOIN societyMember sm ON a.societyID = sm.societyID
                JOIN society s ON a.societyID = s.societyID
                WHERE sm.userID = ?`;
            const [rows] = await db.query(query, [userID]);
            return rows;
        } catch (err) {
            throw err;
        }
    }
}

module.exports = AgendaService;
