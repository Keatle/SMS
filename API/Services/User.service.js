const db = require('../Config/db');
const { v4: uuidv4 } = require('uuid');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const salty = 10;

class userService{



//=======================================================================M O B I L E ================================================================
static async registerUser_M(studentN, name, surname, email, password ){
    try {
        //Hashing the password.
    const hash = await bcrypt.hash(password, salty);

    //Making an entry of the user into the user table.
    const userQuery= 'INSERT INTO user(studentN, name, surname, email, password ) VALUES (?, ?, ?,?, ?)';
    const [userResult] = await db.query(userQuery, [studentN, name,surname, email, hash]);

    //Getting the userID of the user that just registered.
    const userID = userResult.insertId;

    //Quering the roleID
    const roleIDQuery = 'SELECT roleID FROM userRole WHERE roleName = ?';
    const [roleResult] = await db.query(roleIDQuery, ['student']); //Query where the role name is student.
    const roleID = roleResult[0].roleID;

    //Inserting the ID and the role to the role assignment to link the two.
    const roleAAssignment = 'INSERT INTO userRoleAssignment (userID, roleID) VALUES (?,?)';
    await db.query(roleAAssignment, [userID, roleID]);

        return true;

    }
        catch (err){
        console.error('Error in registerUser service:', err);
            throw err;
        }
    }

    static async logiin_M(studentN, password)
    {
    try {
        console.log('Login attempt:', { studentN, password }); 

        //Extracting the prifix of the student number if it exists
        const pref = studentN.charAt(0);
        //If the student number doesn't contain these characters then return a plain student number. False? return false student number.
        const plainStudentN = (pref === 'C' || pref === 'T' || pref === 'S') ? studentN.substring(1) : studentN;

        // Query to find the user by studentN
        const query = 'SELECT * FROM user WHERE studentN = ?';
        const [rows] = await db.query(query, [plainStudentN]);

        console.log('Query result:', rows); 

        if (rows.length > 0)
                {
            const user = rows[0];
            const matching = await bcrypt.compare(password, user.password);

            if (matching) {
                ///Checking if the student login has the required  role.
                if(pref === 'C'|| pref === 'T' || pref === 'S')
                {
                    const roleName = pref === 'C' ? 'chairperson' : pref === 'T' ? 'treasurer' : 'secretary'; // If pref is not T then the role name is assinged to the roleName secreatary.
                    const roleQuery = `
                    SELECT * FROM societyExecutive s
                    JOIN userRole u ON s.roleID = u.roleID
                    WHERE s.userID = ? AND u.roleName = ?`;

                    const [rowRoles] = await db.query(roleQuery, [user.userID, roleName]);
                }

                return user;
            }
        }
        return null;
    } catch (err) {
        throw err;
    }
}

static async getSocietyRequirements_M(societyID)
{
    try{

        const query =  `SELECT r.requirementsID, r.requirementsType, r.reqDescription, CAST(r.requiresDoc AS UNSIGNED) as requiresDoc 
        FROM requirements r 
        JOIN societyRequirements sr ON r.requirementsID = sr.requirementsID 
        WHERE sr.societyID = ?`;
        const [rows] =  await db.query(query, [societyID]);
        console.log(rows); //Why are you only executing one?????
        return rows;
    }
    catch(error)
    {
        throw error;
    }

}

static async saveDocument_M(userID, filePath) {
    try {

        const query = 'INSERT INTO document (userID, uploadDate, filePath) VALUES (?, NOW(), ?)';
        
        const [result] = await db.query(query, [userID, filePath]);
        return result.insertId; 

    } 
    catch (error) {
        throw error;
    }
}

static async linkDocRequirement_M(requirementsID, documentID, userID) {
    try
        {
        const query = 'INSERT INTO requirementsDocuments (documentID, requirementsID, userID) VALUES (?, ?, ?)';
        await db.query(query, [documentID, requirementsID, userID]);
    } 
    catch (error) {
        throw error;
    }
}

static async getApprovedSociety_M()
{
    try
    {
        const approvedQuery = 'SELECT * FROM society WHERE societyStatus = ?';
        const [approvedResult] = await db.query(approvedQuery, ['Approved']);

        return approvedResult;

    }
    catch(error)
    {
        throw error;
    }
}

static async getJoinedSociety_M(userID) {
    try {
        const query = `
        SELECT s.societyID, s.societyName, s.societyIcon, s.societyDescription 
        FROM societyMember ss
        JOIN society s ON ss.societyID = s.societyID
        WHERE ss.userID = ? AND ss.ActiveStatus = 'Active'
    `;

        const [results] = await db.query(query, [userID]);
        return results;
    }
    catch (error) {
        throw error;
    }
}


static async getStudentSocieties_M(userID) {
    try {
        const query = 'SELECT societyID FROM societyMember WHERE userID = ? AND ActiveStatus = "Active"';
        const [rows] = await db.query(query, [userID]);
        return rows.map(society => society.societyID);
    } catch (error) {
        throw error;
    }
}


static async getSocietyNotifications_M(societyIDs, noticeFor) {
    try {
        if (societyIDs.length === 0) {
            return [];
        }
        const notificationsQuery = `
        SELECT n.noticeID, n.title, n.content, n.created_at, n.isRead, s.societyName as society_name
        FROM notices n
        JOIN society s ON n.societyID = s.societyID
        JOIN societyMember sm ON n.societyID = sm.societyID
        WHERE n.societyID IN (?) AND sm.ActiveStatus = 'Active' AND (n.noticeFor = ?)
        ORDER BY n.created_at DESC
    `;
        const [notifications] = await db.query(notificationsQuery, [societyIDs, noticeFor]);
        return notifications;
    } catch (error) {
        throw error;
    }
}

static async getNotifications_M(userID, noticeFor) {
    try {
        const societyIDs = await userService.getStudentSocieties_M(userID);
        const notifications = await userService.getSocietyNotifications_M(societyIDs, noticeFor);



        return notifications;
    } catch (error) {
        throw new Error('Error fetching notifications: ' + error.message);
    }
}


static async markNotificationAsRead_M(noticeID) {
    try {
        const response = await db.query('UPDATE notices SET isRead = ? WHERE noticeID = ?', [true, noticeID]);

        if (response.affectedRows === 0) {
            throw new Error('Notification not found');
        }
    } catch (error) {
        throw new Error('Error updating notification: ' + error.message);
    }
}

static async leaveSociety_M(societyID, userID, reason)
{
    try
    {
        ///Getting the studentID 
        const studentSocietyIDQuery = 'SELECT studentSocietyID FROM societyMember WHERE userID = ? AND societyID = ? AND ActiveStatus = ? ';
        const [studentSocietyIDResult] = await db.query(studentSocietyIDQuery,[userID, societyID, 'Active']);

        console.log('studentSocietyIDResult:',studentSocietyIDResult );
        console.log('userID:', userID);
        console.log('societyID:', societyID);

        if(studentSocietyIDResult === 0)
        {
            throw new Error('Society member not found');

        }

        const studentSocietyID = studentSocietyIDResult[0].studentSocietyID;
        console.log('studentSocietyID:',studentSocietyID );


        ///Updating the statement in the societyMEmber table
        const updateStatusQuery = 'UPDATE societyMember SET ActiveStatus = ? WHERE studentSocietyID = ?';
        await db.query(updateStatusQuery, ['Inactive',studentSocietyID]);

        //Adding the reason for leaving the society
        const addMemberQuery = 'INSERT INTO reasonforleaving (studentSocietyID, reason) VALUES (?, ?)';
        await db.query(addMemberQuery, [studentSocietyID, reason]);
        
    }
    catch(error)
    {
        throw error;
    }

}


static async getUserNameSurname_M(userID)
{
    try
    {
        const getNameQuery = 'SELECT name, surname FROM user WHERE userID = ?';
        const [getNameResult] = await db.query(getNameQuery, [userID]);
        return getNameResult;

    }
    catch(error)
    {
        throw error;
    }
}


static async sendPasswordOTP_M(email)
{
    try
    {
        const getUserQuery = 'SELECT userID FROM user WHERE email = ?';
        const [userResult] = await db.query(getUserQuery, [email]);

        if(userResult.length === 0)
        {
            throw new Error('The user is not found');
        }

        const otp = Math.floor(100000 + Math.random() * 900000).toString();
        const expiresAt = new Date(Date.now()+ 10 * 60 *1000); //The otp will expire in 10 minutes

        const inputOTP = 'INSERT INTO otpNumber (email, otp, expiresAt, isUsed) VALUES (?, ?, ?, ?)';
        await db.query(inputOTP, [email, otp, expiresAt, false]);

        //Sending the actual email to the user
      let   sentEmail = await this.sendOPTEmail_M(email, otp);
        return sentEmail;
    }
    catch(error)
    {
        throw error;
    }
}

static async sendOPTEmail_M(email, otp) {
    try {
        // Transporter to transport our email
        let emailTransporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: process.env.EMAIL,
                pass: process.env.EMAIL_PASSWORD,
            },
        });

        // Set up the email subject, body, and credentials
        const mailOptions = {
            from: process.env.EMAIL,
            to: email,
            subject: 'YOUR OTP CODE',
            text: `Your OTP code is ${otp}. It will expire in 10 minutes.`,
            html: `<p>Your OTP code is <strong>${otp}</strong>. It will expire in 10 minutes.</p>`,
        };

        // Sending the email using our transporter
        let info = await emailTransporter.sendMail(mailOptions);
        console.log('Message sent: %s', info.messageId);
        return { message: 'OTP is sent successfully' };

    } catch (error) {
        console.error('Error sending the OTP message:', error);
        if (error.response) {
            console.error('Response data:', error.response.data);
            console.error('Response status:', error.response.status);
            console.error('Response headers:', error.response.headers);
        }
        throw error;
    }
}


static async verifyOTP(email, otp)
{
   try
   {
     //Retrieving the otp from the database
     const getOTPQuery = 'SELECT otp, expiresAt, isUsed FROM otpNumber WHERE email = ? ORDER BY expiresAt DESC LIMIT 1';
     const [otpResult] = await db.query(getOTPQuery, [email]);
 
     const {otp: storedOTP, expiresAt, isUsed} = otpResult[0];
 
     if(isUsed)
     {
         return false;
     }
 
     //Checking if the provided OTP matches the stored OTP
     if(storedOTP !== otp)
     {
         return false;
     }
 
     //If everything is correct, mark the otp as used
     const updateOTPQuery = 'UPDATE otpNumber SET isUsed = true WHERE email = ? AND otp = ?';
     await db.query(updateOTPQuery, [email, otp]);
 
     return true;

   }
   catch(error)
   {
    throw error;
   }
}


static async resetPassword(email, newPassword)
{
    try
    {
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(newPassword, saltRounds);

    //Updating the user's password 
    const updatePasswordQuery = 'UPDATE user SET password = ? WHERE email = ?';
    await db.query(updatePasswordQuery, [hashedPassword, email]);

    return {message: 'Password reset successfully'};

    }
    catch(error)
    {
        throw error;
        console.error('Error resseting the password:', error);
    }
}

static async getIcon_M(societyID) {
    try {
        const query = 'SELECT societyIcon FROM society WHERE societyID = ?';
        const [rows] = await db.query(query, [societyID]);

      if (rows.length > 0) {
        return rows[0].societyIcon; 
      } else {
            return null;
        }
    } catch (error) {
        throw error;
    }
}


static async categorizeSocieties_M()
{
    try
    {
        
        const departments = ['Religious', 'Academic', 'Entertainment', 'Sport', 'Political', 'Culture'];


        const departmentResults = [];


        for(const department of departments)
        {
            const departmentQuery = 'SELECT societyName from society WHERE department = ? ORDER BY societyName  ASC';

            const [departmentQueryResult] = await db.query(departmentQuery, [department]);

            //Adding our results to the array
            departmentResults.push({
                department: department,
                societies: departmentQueryResult
            });
        }
        return departmentResults;
    }
    catch(error)
    {
        throw error;
    }

}

static async getReligiousSocieties_M()
{
    try
    {
       const query = 'SELECT * FROM society WHERE department = ? ORDER BY societyName ASC';
       
       const [relResults] = await db.query(query, ['Religion']);

       return relResults;
    }
    catch(error)
    {
        throw error;
    }
}

static async getAcademicSocieties_M()
{
    try
    {
       const query = 'SELECT * FROM society WHERE department = ? ORDER BY societyName ASC';
       
       const [acaResults] = await db.query(query, ['Academic']);

       return acaResults;
    }
    catch(error)
    {
        throw error;
    }
}


static async getPoliticalSocieties_M()
{
    try
    {
       const query = 'SELECT * FROM society WHERE department = ? ORDER BY societyName ASC';
       
       const [politicalResults] = await db.query(query, ['Political']);

       return politicalResults;
    }
    catch(error)
    {
        throw error;
    }
}
   
static async getEntertainmentSocieties_M()
{
    try
    {
       const query = 'SELECT * FROM society WHERE department = ? ORDER BY  societyName ASC';
       
       const [entResults] = await db.query(query, ['Entertainment']);

       return entResults;
    }
    catch(error)
    {
        throw error;
    }
}

static async getSportSocieties_M()
{
    try
    {
       const query = 'SELECT * FROM society WHERE department = ? ORDER BY societyName ASC';
       
       const [sportResults] = await db.query(query, ['Sport']);

       return sportResults;
    }
    catch(error)
    {
        throw error;
    }
}

static async getCultureSocieties_M()
{
    try
    {
       const query = 'SELECT * FROM society WHERE department = ? ORDER BY societyName ASC';
       
       const [cultureResults] = await db.query(query, ['Culture']);

       return cultureResults;
    }
    catch(error)
    {
        throw error;
    }
}


static async getCultureSocieties_M()
{
    try
    {
       const query = 'SELECT * FROM society WHERE department = ? ORDER BY societyName ASC';
       
       const [cultureResults] = await db.query(query, ['Culture']);

       return cultureResults;
    }
    catch(error)
    {
        throw error;
    }
}


static async searchSocietyName_M(searchQuery)
{
    try
    {
        const query = 'SELECT * FROM society WHERE societyName LIKE ? ORDER BY societyName ASC';

        //Using the '%' wild cards to perform a case-insensitive search!!!
        const [serachResults] = await db.query(query, [`%${searchQuery}%`]);
        return serachResults;
    }
    catch(error)
    {
        throw error;
    }
}


//Searching society name'
static async searchPendingSocieties_M(searchQuery)
{
    try
    {
        const query = `
            SELECT r.*, s.societyName 
            FROM requests r
            JOIN society s ON r.societyID = s.societyID
            WHERE s.societyName LIKE ?
            AND r.requestStatus = 'pending'
            ORDER BY s.societyName ASC
        `;

        //Using the '%' wild cards to perform a case-insensitive search!!!
        const [serachResults] = await db.query(query, [`%${searchQuery}%`]);
        return serachResults;
    }
    catch(error)
    {
        throw error;
    }
}

//Search event name
static async searchEventname_M(searchQuery)
{
    try
    {
        const query = 'SELECT * FROM eventData WHERE eventName LIKE ? ORDER BY eventName ASC';
        //Using the '%' wild cards to perform a case-insensitive search!!!
        const [serachResults] = await db.query(query, [`%${searchQuery}%`]);
        return serachResults;

    }
    catch(error)
    {
        throw error;
    }
}

//Search notice title
static async searchNotificationTitle_M(searchQuery)
{
    try
    {
        const query = 'SELECT * FROM notices WHERE title LIKE ? ORDER BY title ASC';
        //Using the '%' wild cards to perform a case-insensitive search!!!
        const [serachResults] = await db.query(query, [`%${searchQuery}%`]);
        return serachResults;

    }
    catch(error)
    {
        throw error;
    }
}

//Search minutes title 
static async searchMinutesTitle_M(searchQuery)
{
    try
    {
        const query = 'SELECT * FROM minutes WHERE meetingTitle LIKE ? ORDER BY meetingTitle ASC';
        //Using the '%' wild cards to perform a case-insensitive search!!!
        const [serachResults] = await db.query(query, [`%${searchQuery}%`]);
        return serachResults;

    }
    catch(error)
    {
        throw error;
    }
}

static async getUserIdByStudentNumber_M(studentN) {
try {
    const query = 'SELECT userID FROM user WHERE studentN = ?';
    const [rows, _] = await db.query(query, [studentN]);
    return rows.length ? rows[0].userID : null;
} 
catch (err) {
    throw err;
 }
};



static async requestSociety_M(userID, societyID, requestStatus, requestDate) {
    try {
        
        const requestQuery = 'INSERT INTO requests(userID, societyID, requestStatus, requestDate) VALUES (?, ?, ?, NOW())';
        await db.query(requestQuery, [userID, societyID, requestStatus]);


        const societyMemberQuery = `
            INSERT INTO societyMember(userID, societyID, ActiveStatus) 
            VALUES (?, ?, 'Pending')
            ON DUPLICATE KEY UPDATE ActiveStatus = 'Pending'
        `;
        await db.query(societyMemberQuery, [userID, societyID]);

        return true;
    } catch (err) {
        throw err;
    }
}


static async getPendingSocietiesForUser_M(userID) {
    try {
        const query = `
            SELECT s.societyID, s.societyName, s.societyIcon, r.requestStatus, r.requestDate 
            FROM society s
            JOIN requests r ON s.societyID = r.societyID
            WHERE r.userID = ? AND r.requestStatus = 'pending'
        `;
        const [rows] = await db.query(query, [userID]);
        return rows;
    } catch (err) {
        throw err;
    }
};

static async getMinutesByUserId_M(userId) {
    try {
        const query = `
            SELECT m.*, s.societyName 
            FROM minutes m
            JOIN societyMember sm ON m.societyID = sm.societyID
            JOIN society s ON m.societyID = s.societyID
            WHERE sm.userID = ?`;
        const [rows] = await db.query(query, [userId]);
        return rows;
    } catch (err) {
        throw err;
    }
};

static async getAllRequests_w(societyID) {
    try {
        const query = `
            SELECT 
            u.userID,
                u.name,
                u.surname,
                u.studentN,
                s.societyID,
                s.societyName
            FROM 
                user u
            JOIN 
                societymember sm ON u.userID = sm.userID 
            JOIN 
                society s ON sm.societyID = s.societyID 
            WHERE 
                sm.societyID = ? 
                AND sm.ActiveStatus = 'Pending'
                AND (EXISTS (SELECT 1 FROM requirementText rt WHERE rt.userID = u.userID) 
                OR EXISTS (SELECT 1 FROM document d WHERE d.userID = u.userID));
        `;

        const values = societyID ? [societyID] : [];

        const [rows, _fields] = await db.query(query, values);
        return rows;
    } catch (err) {
        throw err;
    }
}
 
static async addToSocietyMember_w(userID, societyID, ActiveStatus, statusUpdate){
    try {
        const statusUpdate = new Date(); 
        const query = `
            INSERT INTO societymember (userID, societyID, ActiveStatus, statusUpdate) VALUES (?, ?, ?, ?)
        `;
        await db.query(query, [userID, societyID, ActiveStatus, statusUpdate]);
    
      // Query to get the society name based on societyID
        const societyQuery = `SELECT societyName FROM society WHERE societyID = ?`;
    
        // Retrieve society name from the database
        const [societyResult] = await db.query(societyQuery, [societyID]);
    
        if (societyResult.length > 0) {
            const societyName = societyResult[0].societyName;
    
            // Now insert the notice with the retrieved societyName
            const NoticeQuery = 'INSERT INTO notices(societyID, title, content, created_at, noticeFor, status) VALUES (?, ?, ?, NOW(), ?, ?)';
            await db.query(NoticeQuery, [
                societyID, 
                'Society Request', 
                `Society request to "${societyName}" was successfully sent!`, 
                userID, 
                'Active'
            ]);
        } else {
            console.error('Society not found');
        }
    
                return true;
            } 
            catch (err) {
                throw err;
            }
  }


  static async updateMemberActiveStatus_w(userID, societyID, ActiveStatus) {
    try {
        // Validate ActiveStatus
        const validStatuses = ['active', 'declined'];
        if (!validStatuses.includes(ActiveStatus.toLowerCase())) {
            throw new Error('Invalid ActiveStatus value. Must be "active" or "declined".');
        }

        const statusUpdateDate = new Date(); 

        // Update ActiveStatus in societymember table
        const updateMemberQuery = 'UPDATE societymember SET ActiveStatus = ?, statusUpdate = ? WHERE userID = ? AND societyID = ?';
        const [updateMemberResult] = await db.query(updateMemberQuery, [ActiveStatus, statusUpdateDate, userID, societyID]);

        if (updateMemberResult.affectedRows === 0) {
            return { message: 'No member found with the provided userID and societyID.' };
        }

        // Determine the requestStatus based on ActiveStatus
        let requestStatus;
        if (ActiveStatus.toLowerCase() === 'active') {
            requestStatus = 'approved';
        } else {
            requestStatus = 'declined';
        }

        // Update statusUpdate and requestStatus in requests table
        const updateRequestQuery = 'UPDATE requests SET statusUpdate = ?, requestStatus = ? WHERE userID = ? AND societyID = ?';
        const [updateRequestResult] = await db.query(updateRequestQuery, [statusUpdateDate, requestStatus, userID, societyID]);

        if (updateRequestResult.affectedRows === 0) {
            return { message: 'No pending request found for the provided userID and societyID.' };
        }

        return { message: 'Member status and request date updated successfully!' };
    } catch (error) {
        console.error('Error in updateMemberActiveStatus_w service:', {
            userID,
            societyID,
            ActiveStatus,
            error: error.message,
            stack: error.stack
        });
        throw new Error('Failed to update member status. Please try again later.');
    }
}



static async saveText_M( requirementsID, userID,textValue)
{
    try
    {
        const textQuery = 'INSERT INTO requirementText (requirementsID, userID, textValue) VALUES (?,?,?)';
        await db.query(textQuery, [requirementsID, userID,textValue]);
    }
    catch(error)
    {
        throw error
    }
}

    // budgetService.js
    static async getBudgetDetails_M(userID) {
        try {
            const getBudgetQuery = `
            SELECT b.SocietyName, b.Title, b.Description, b.Status, b.created_at 
            FROM budget b
            JOIN societyMember sm ON b.societyID = sm.societyID
            JOIN society s ON b.societyID = s.societyID
            WHERE sm.userID = ?`;
        
            const [getResult] = await db.query(getBudgetQuery, [userID]);
        
            if (getResult.length === 0) {
            return { message: 'No budget updates available' }; // Return a message if no results
            }
        
            return getResult;
        } catch (error) {
            throw new Error('Error fetching budget details: ' + error.message);
        }
        }

static async countUnreadNotifications(userID) {
    try {
        const getUnreadNotifications = `
        SELECT COUNT(*) AS unreadCount
        FROM notices n
        JOIN societyMember sm ON n.societyID = sm.societyID
        WHERE sm.userID = ? AND n.isRead = 0`;
    
        const [getResult] = await db.query(getUnreadNotifications, [userID]);
    
    
        return getResult[0].unreadCount;
    } catch (error) {
        throw new Error('Error fetching notification details: ' + error.message);
    }
 }

 static async searchPendingSocietyName_M(searchQuery)
 {
     try
     {
         const query = `SELECT s.societyID, s.societyName, s.societyDescription, s.societyIcon
             FROM societymember sm
             JOIN society s ON sm.societyID = s.societyID
             WHERE sm.userID = ? AND sm.ActiveStatus = 'Active' AND s.societyName LIKE ?;
             `;
 
         //Using the '%' wild cards to perform a case-insensitive search!!!
         const [serachResults] = await db.query(query, [`%${searchQuery}%`]);
         return serachResults;
     }
     catch(error)
     {
         throw error;
     }
 }
 





}
//exportin class
module.exports= userService;