const minutesService = require('../Services/minutes.service');

// Get minutes by student number
exports.getMinutesBSN = async (req, res, next) => {
    try {
        const { studentN } = req.params;

        // Check if the student number starts with c, t, or s (case insensitive)
        if (/^[cts]/i.test(studentN)) {
            const userId = await minutesService.getUserIdByStudentNumber(studentN);

            if (!userId) {
                return res.json({ nextStatus: false, message: "No meeting minutes available" });
            }

            const minutes = await minutesService.getMinutesByUserId(userId);

            if (minutes.length === 0) {
                return res.json({ nextStatus: false, message: "No meeting minutes available" });
            }

            res.json({ nextStatus: true, minutes });
        } else {
            res.status(400).json({ nextStatus: false, message: "Invalid student number format" });
        }
    } catch (err) {
        next(err);
    }
};

// READ: Retrieve all minutes
exports.getMinutes = async (req, res, next) => {
    try {
        const minutes = await minutesService.getMinutes();
        res.json(minutes);
    } catch (err) {
        next(err);
    }
};

// READ: Retrieve a single minute by ID
exports.getMinuteById = async (req, res, next) => {
    try {
        const { minutesID } = req.params;
        const minute = await minutesService.getMinuteById(minutesID);
        res.json(minute);
    } catch (err) {
        next(err);
    }
};
