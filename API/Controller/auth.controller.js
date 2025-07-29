const passwordService = require('../Services/auth.service');

const changePassword = async (req, res) => {
  try {
    const { studentN, currentPassword, newPassword } = req.body;

    if (!studentN || !currentPassword || !newPassword) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await passwordService.changePassword(studentN, currentPassword, newPassword);
    res.status(200).json(result);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

module.exports = { changePassword };


