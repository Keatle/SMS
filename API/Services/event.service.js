const db = require('../Config/db');

class EventService {
    static async getEventsBySN(studentN) {
        try {
            // Trim and log the studentN
            studentN = studentN.trim();
            console.log('Retrieving userID for studentN:', studentN);

            // Retrieve userID from student number
            const userQuery = 'SELECT userID FROM user WHERE studentN = ?';
            console.log('Executing user query:', userQuery, [studentN]);
            const [userRows] = await db.query(userQuery, [studentN]);

            console.log('User query result:', userRows); // Log query result

            if (userRows.length === 0) {
                console.log("No user found with the provided student number");
                return "No user found with the provided student number";
            }

            const userID = userRows[0].userID;
            console.log('Resulting userID for studentN:', userID);

            const eventsQuery = `
                SELECT e.*, s.societyName
                FROM event e
                JOIN societyMember sm ON e.societyID = sm.societyID
                JOIN society s ON e.societyID = s.societyID
                WHERE sm.userID = ?
            `;
            console.log('Executing events query:', eventsQuery, [userID]);
            const [eventsRows] = await db.query(eventsQuery, [userID]);

            console.log('Events query result:', eventsRows); // Log query result

            if (eventsRows.length === 0) {
                return "No upcoming events";
            }

            return eventsRows;
        } catch (err) {
            console.error('Error retrieving events:', err);
            throw err;
        }
    }

    // Other methods
    static async getEvents() {
        try {
            const query = 'SELECT * FROM event';
            const [rows, _fields] = await db.query(query);
            return rows;
        } catch (err) {
            throw err;
        }
    }

    static async getEventById(eventID) {
        try {
            const query = 'SELECT * FROM event WHERE eventID = ?';
            const [rows, _fields] = await db.query(query, [eventID]);
            return rows[0];
        } catch (err) {
            throw err;
        }
    }
}

module.exports = EventService;
