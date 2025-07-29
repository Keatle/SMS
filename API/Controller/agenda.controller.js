const AgendaService = require('../Services/agenda.service');

// READ: Retrieve all agendas based on student number
exports.getAgendas = async (req, res, next) => {
    try {
        const { studentN } = req.params; // Note the change from req.query to req.params

        // Check if the student number starts with c, t, or s (case insensitive)
        if (/^[cts]/i.test(studentN)) {
            const userID = await AgendaService.getUserIdByStudentNumber(studentN);

            if (!userID) {
                return res.json({ nextStatus: false, message: "No agendas found for the given student number" });
            }

            const agendas = await AgendaService.getAgendasByUserId(userID);

            if (agendas.length === 0) {
                return res.json({ nextStatus: false, message: "No upcoming agendas" });
            }

            res.json({ nextStatus: true, agendas });
        } else {
            res.status(400).json({ nextStatus: false, message: "Invalid student number format" });
        }
    } catch (err) {
        next(err);
    }
};

