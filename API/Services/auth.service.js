const db = require('../Config/db');
const bcrypt = require('bcrypt'); // For password hashing

const changePassword = async (studentN, currentPassword, newPassword) => {
  try {
    // Find the user by student number
    const user = await db.user.findOne({ where: { studentN } });
    if (!user) {
      throw new Error('User not found');
    }

    // Check if current password matches
    const isMatch = await bcrypt.compare(currentPassword, user.password);
    if (!isMatch) {
      throw new Error('Current password is incorrect');
    }

    // Hash new password and update
    const hashedNewPassword = await bcrypt.hash(newPassword, 10);
    user.password = hashedNewPassword;
    await user.save();

    return { success: 'Password successfully changed' };
  } catch (error) {
    throw error;
  }
};

module.exports = { changePassword };
