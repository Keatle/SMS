
//======================================================================= M O B I L E ======================================================
exports.registerUser_M = async (req, res) => {
    try
    {
        const { studentN,  name, surname, email, password} = req.body;
        console.log('Received data:', req.body);
        
        //Calling our service function.
        const result = await userService.registerUser_M(studentN, name ,surname, email, password)
       // const result = await userService.register(studentN, name ,surname, email, password);

        if(result)
        {
            res.status(200).json({message: 'Account has been created successfully', data: result});
        }
        else
        {
            res.status(400).json({message: 'Account creation has failed!'})
        }

    }
    catch(error)
    {
        console.log('Error enountered during registration', error);
        res.status(500).json({message: 'Failed to create the account!'});
    }

    

}

exports.signin_M = async (req, res, next) => {
    try {
        const { studentN, password } = req.body;
        const user = await userService.logiin_M(studentN, password);

        if (user) {
            // Generate JWT token
            const token = jwt.sign({ userID: user.userID }, process.env.JWT_SECRET || 'secrete', { expiresIn: '2h' });

            //Determining the student role
            let role = 'student';
            if(studentN.charAt(0) === 'C') role = 'chairperson';
            if(studentN.charAt(0) === 'T') role = 'treasurer';
            if(studentN.charAt(0) === 'S') role = 'secretary';


            // Send response with token and user information
            res.status(200).json({ message: 'Login Successful', token, user });
        } else {
            // Send response for invalid credentials
            res.status(401).json({ message: 'Invalid credentials' });
        }
    } catch (err) {
        next(err); 
    }
};


exports.getRequirements_M = async (req, res) => {
    try{
        const  societyID  = req.params.societyID;

        //facing some issues, let's debug. 
        if(!societyID)
        {
            return res.status(400).json({error: 'Where is the societyID??????'});

        }
        const societyrequirements = await userService.getSocietyRequirements_M(societyID);
        console.log('Society Requirements: ', societyrequirements); //Debugging the output, because why is it outputting one??????
        
        res.status(200).json(societyrequirements);
    }
    catch (error)
    {
        console.error('Could not retrieve requirements by society:', error);
        res.error;
    }
}; 

exports.uploadDocument_M = async (req, res, next) =>
    {
        try
        {
            const { requirementsID} = req.params;
            const { userID } = req.params;
            const file = req.file;
    
            if(!file)
            {
                return res.status(400).json({
                    error: 'File has not been uploaded!'
                });
            }
    
            const filePath = `/uploads/${file.filename}`;
    
            const documentID = await userService.saveDocument_M(userID ,filePath);
    
            await userService.linkDocRequirement_M(requirementsID, documentID, userID);
    
            res.json({
                success: 'Documents have been uploaded and linked to the requirement successfully'
            });
    
    
    
        }
        catch(error)
        {
            next(error);
        }
    }



    exports.downloadDocument = async (req, res) =>
    {
        try
        {
            const {documentID} = req.params;
    
            const fileData = await userService.getDocumentByID(documentID);
    
            if (!fileData || !fileData.filePath) {
                return res.status(404).json({ error: 'Document not found' });
            }
    
            const relativeFilePath = fileData.filePath; 
            
    
            const absoluteFilePath = path.join(__dirname, '../..', relativeFilePath);
    
            res.download(absoluteFilePath, (err) => {
                if (err) {
                    return next(err);
                }
            });
    
        }
        catch(error)
        {
            throw error;
        }
    }
    

exports.getApprovedSociety_M = async (req, res) =>
    {
        try
        {
            const societies = await userService.getApprovedSociety_M();  

            res.status(200).json(societies);

        }
        catch(error)
        {
            res.error;
        }
    }

exports.getJoinedSociety_M = async (req, res) =>
{
    const {userID} = req.params;

    try{
        const results = await userService.getJoinedSociety_M(userID);
        res.status(200).json(results);
    }
    catch(error)
    {
        console.error(error);
        throw(error);

    }
}

exports.getNotifications_M = async (req, res) => {
    const { userID, noticeFor } = req.params;

    if (!userID) {
        return res.status(400).json({ error: 'User ID is required' });
    }

    try {
        const notifications = await userService.getNotifications_M(userID, noticeFor);
        res.status(200).json(notifications); 
    } catch (error) {
        console.error('Error fetching notifications:', error.message);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};


exports.markNotificationAsRead_M = async (req, res) => {
    const { noticeID } = req.params;

    if (!noticeID) {
        return res.status(400).json({ error: 'Notification ID is required' });
    }

    try {
        await userService.markNotificationAsRead_M(noticeID);
        res.status(200).json({ message: 'Notification marked as read' });
        console.log('Message: NOtification marked as read!')
    } catch (error) {
        console.error('Error updating notification:', error.message);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};


exports.leaveSociety_M = async (req, res) => {
    const { societyID, userID} = req.params;
    const {reason} = req.body;

    try {
        const result = await userService.leaveSociety_M(societyID, userID, reason);

        res.status(200).json(result);
    } catch (error) {
        console.error('Error leaving a  society:', error);
        res.status(500).json({ message: 'Failed to leave a society' });
    }
};

exports.getUserNameSurname_M = async (req, res) => {
    
    try
    {
        const {userID} = req.params;
        const result = await userService.getUserNameSurname_M(userID);
        res.json(result);

    }
    catch(error)
    {
        res.error;
        res.status(500).json({message: 'There is an internal error', error});
    }
}

exports.sendPasswordOTP_M = async (req, res, next) =>
    {
        try
        {
            const { email } = req.body;
    
        if(!email)
        {
            return res.status(400).json({error: 'No email is provided!'});
    
        }
    
         let emailSent = await userService.sendPasswordOTP_M(email);
        res.json({success: 'Email has been submitted successfully', emailSent});
        }
        catch(error)
        {
            next(error);
        }
    }
      
    
exports.verifyOTP = async (req, res) =>
{
    try
    {
        const {email, otp} = req.body;
        if(!email || !otp)
        {
            return res.status(400).json({error: 'Please write the email and the OTP sana!'});
        }

        const isVerified = await userService.verifyOTP(email, otp);
        
        if(isVerified)
        {
            return res.json({success: 'OTP verified successfully'});

        }
        else
        {
            return res.status(400).json({success: 'OTP verified unsuccessfully'});

        }

    }
    catch(error)
    {
        throw error;
        
    }
}

exports.resetPassword = async (req, res) =>
{
    try
    {
        const {email, otp, newPassword} = req.body;
    if(!email, !otp, !newPassword)
    {
        return res.status(400).json({error: 'Email, OTP, and the new password are missing'});

    }

    //Verifying the OTP first
    const isVerified = await userService.verifyOTP(email, otp);

    if(!isVerified)
    {
        return res.status(400).json({error: 'Invalid or expired otp'});
    }

    await userService.resetPassword(email, newPassword);
    res.json({success: 'Password has been reset successfully!!'});

    }
    catch(error)
    {
        throw error;
    }
}

exports.getIcon_M = async (req, res, next) => {
    try {
        const { societyID } = req.params;
        const icon = await userService.getIcon_M(societyID);

        if (icon) {
            
            res.status(200).json({ icon });
        } else {
            res.status(404).json({ error: 'Icon not found' });
        }
    } catch (error) {
        console.error('Could not retrieve the icon:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

exports.categorizeSocieties_M = async (req, res) =>
{
    try
    {
        const categorizedDepartment  = await userService.categorizeSocieties_M();
        res.json({categorizedDepartment});
    }
    catch(error)
    {
        console.error('Error fetching societies by their departments', error);
        throw error;
    }
    
}
    
    
exports.getReligiousSocieties_M = async (req, res) =>
{
    try
    {
        const societies  = await userService.getReligiousSocieties_M();
        res.json({societies});
    }
    catch(error)
    {
        console.error('Error fetching religious societies ', error);
        throw error;
    }
    
}
    
    
exports.getAcademicSocieties_M = async (req, res) =>
{
    try
    {
        const societies  = await userService.getAcademicSocieties_M();
        res.json({societies});
    }
    catch(error)
    {
        console.error('Error fetching academic societies ', error);
        throw error;
    }
    
}
    
    
    
exports.getEntertainmentSocieties_M = async (req, res) =>
{
    try
    {
        const societies  = await userService.getEntertainmentSocieties_M();
        res.json({societies});
    }
    catch(error)
    {
        console.error('Error fetching entertainment societies ', error);
        throw error;
    }
    
}
        
    
        
exports.getSportSocieties_M = async (req, res) =>
{
    try
    {
        const societies  = await userService.getSportSocieties_M();
        res.json({societies});
    }
    catch(error)
    {
        console.error('Error fetching sport societies ', error);
        throw error;
    }
    
}
    
        
exports.getPoliticalSocieties_M = async (req, res) =>
{
    try
    {
        const societies  = await userService.getPoliticalSocieties_M();
        res.json({societies});
    }
    catch(error)
    {
        console.error('Error fetching political societies ', error);
        throw error;
    }
    
}
    
        
exports.getCultureSocieties_M = async (req, res) =>
{
    try
    {
        const societies  = await userService.getCultureSocieties_M();
        res.json({societies});
    }
    catch(error)
    {
        console.error('Error fetching culture societies ', error);
        throw error;
    }
    
}


exports.searchSocietyByName_M = async (req, res) => {
    try
    {
     const searchQuery = req.body.query;
 
     if(!searchQuery)
     {
         return res.status(400).json({message: 'Search query is required'});
     }
 
     const societies = await userService.searchSocietyName_M(searchQuery);
     res.json({societies});
 
    }
    catch(error)
    {
     console.log('Error searching societies', error);
     res.status(500).json({message: 'Failed to search the society'});
    }
 }
 
exports.searchPendingSocieties_M = async (req, res) => {
    try
    {
    const searchQuery = req.body.query;

    if(!searchQuery)
    {
        return res.status(400).json({message: 'Search query is required'});
    }

    const societies = await userService.searchPendingSocieties_M(searchQuery);
    res.json({societies});

    }
    catch(error)
    {
    console.log('Error searching societies', error);
    res.status(500).json({message: 'Failed to search the society'});
    }
}
 
exports.searchEventByName_M = async (req, res) => {
    try
    {
    const searchQuery = req.body.query;

    if(!searchQuery)
    {
        return res.status(400).json({message: 'Search query is required'});
    }

    const societies = await userService.searchEventname_M(searchQuery);
    res.json({societies});

    }
    catch(error)
    {
    console.log('Error searching societies', error);
    res.status(500).json({message: 'Failed to search the society'});
    }
}
 
exports.searchNotificationByTitle_M = async (req, res) => {
    try
    {
    const searchQuery = req.body.query;

    if(!searchQuery)
    {
        return res.status(400).json({message: 'Search query is required'});
    }

    const societies = await userService.searchNotificationTitle_M(searchQuery);
    res.json({societies});

    }
    catch(error)
    {
    console.log('Error searching societies', error);
    res.status(500).json({message: 'Failed to search the society'});
    }
}
 
exports.searchMinutesByTitle_M = async (req, res) => {
    try
    {
    const searchQuery = req.body.query;

    if(!searchQuery)
    {
        return res.status(400).json({message: 'Search query is required'});
    }

    const societies = await userService.searchMinutesTitle_M(searchQuery);
    res.json({societies});

    }
    catch(error)
    {
    console.log('Error searching societies', error);
    res.status(500).json({message: 'Failed to search the society'});
    }
}



exports.requestSociety_M=async (req, res, next)=>{
    try{
        const {userID, societyID,requestStatus, requestDate}= req.body;
        await userService.requestSociety_M(userID, societyID,requestStatus, requestDate);
        res.json({nextStatus: true , success: "Application Successfully submitted."})

    }catch(err){
        next (err);
    }
}

exports.getPendingSocietiesForUser_M = async (req, res, next) => {
    try {
        const { userID } = req.params;
        const pendingSocieties = await userService.getPendingSocietiesForUser_M(userID);
        res.json(pendingSocieties);
    } catch (err)
    {
        next(err);
    }
};

exports.getMinutesBSN_M = async (req, res, next) => {
    try {
        const { studentN } = req.params;

        // Check if the student number starts with c, t, or s (case insensitive)
        if (/^[cts]/i.test(studentN)) {
            const userID = await userService.getUserIdByStudentNumber_M(studentN);

            if (!userID) {
                return res.json({ nextStatus: false, message: "No meeting minutes available" });
            }

            const minutes = await userService.getMinutesByUserId_M(userID);

            if (minutes.length === 0) {
                return res.json({ message: "No meeting minutes available" });
            }

            res.json({ nextStatus: true, minutes });
        } else {
            res.status(400).json({ nextStatus: false, message: "Invalid student number format" });
        }
    } catch (err) {
        next(err);
    }
};

exports.submitText_M = async (req, res, next) =>
    {
        try
        {
            const { requirementsID, userID } = req.params;
        const {textValue} = req.body;

        if(!textValue)
        {
            return res.status(400).json({error: 'No text value was provided!'});

        }

        await userService.saveText_M(requirementsID, userID, textValue);
        res.json({success: 'Text field data has been submitted successfully'});
        }
        catch(error)
        {
            next(error);
        }
    }



exports.getBudgetDetails_M = async (req, res) => {
try {
    const { userID } = req.params; // Get userID from request parameters

    if (!userID) {
    return res.status(400).json({ success: false, error: 'Invalid userID' });
    }

    const budgets = await userService.getBudgetDetails_M(userID);

    console.log('Raw query result:', budgets); // Log the raw result from db.query

    if (budgets.message) {
    return res.status(404).json({ success: false, message: budgets.message }); // Handle no results case
    }
    res.status(200).json({
    success: true,
    budgets: budgets, 
    });
} catch (error) {
    console.error('Error in getBudgetDetails_M:', error);
    res.status(500).json({
    success: false,
    error: error.message || 'Internal server error',
    });
}
 }

exports.countUnreadNotifications = async (req, res) =>
{
    try
    {
        const { userID } = req.params;
        const enreadCount = await userService.countUnreadNotifications(userID);
        res.status(200).json({ enreadCount });
        
    
    }
    catch(error)
    {
        throw error;
    }
}
