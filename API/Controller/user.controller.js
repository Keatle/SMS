/*const {json}=require('body-parser');
const userService= require('../Services/user.service');
const { request } = require('http');
const { v4: uuidv4 } = require('uuid');
const path = require('path');
const jwt = require('jsonwebtoken');
const { read } = require('fs');


exports.register = async (req, res) => {
    try {
      const { studentN,  name, surname, email, password} = req.body;
      console.log('Received data:', req.body); 
  
      const result = await userService.register(studentN, name, surname, email, password);
      res.json({ message: 'Account Created Successful', data: result });
    } catch (error) {
      console.error('Error during user registration:', error);
      res.status(500).json({ message: 'Failed to create account' });
    }
  };
  
  
  exports.login = async (req, res, next) => {
    try {
        const { studentN, password } = req.body;
        const user = await userService.login(studentN, password);

        if (user) {
            // Generate JWT token
            const token = jwt.sign({ userID: user.userID }, process.env.JWT_SECRET || 'secrete', { expiresIn: '2h' });

            // Send response with token and user information
            res.status(200).json({ message: 'Login Successful', token, user });
        } else {
            // Send response for invalid credentials
            res.status(401).json({ message: 'Invalid credentials' });
        }
    } catch (err) {
        next(err); // Pass the error to the error handling middleware
    }
};

<<<<<<< HEAD:backend/SocietyManagementApi/Controller/userControler.js
=======
exports.login= async(req, res, next)=>{
try{
const {email, password}= req.body;
const user = await userService.login(email, password);
if(user)
{
    const token = jwt.sign({userID: user.userID}, process.env.JWT_SECRET || 'secrete', {expiresIn: '2h'});
    res.json({token});
}
else{
    res.status(401).json({message: 'Invalid credentials '});  
}
}catch(err){
    
    next (err); 
}
}
>>>>>>> 1d879125cd14ee14e2dc7d92bbb6f9122aaa59b3:backend/SocietyManagementApi/Controller/user.controller.js

exports.registerSociety = async (req, res, next) => {
    try {
        const { societyName, societyDescription, department } = req.body;
        const { societyIcon, societyConstitution, societyExecutiveList, societyPetitionList, societyYearPlan, societyBudget, societyPayment } = req.files;

        if (!societyIcon || !societyConstitution || !societyExecutiveList || !societyPetitionList || !societyYearPlan || !societyBudget || !societyPayment) {
            return res.status(400).json({ error: 'One or more required files are missing.' });
        }

        const iconPath = `/uploads/${societyIcon[0].filename}`;
        const constitutionPath = `/uploads/${societyConstitution[0].filename}`;
        const executiveListPath = `/uploads/${societyExecutiveList[0].filename}`;
        const petitionListPath = `/uploads/${societyPetitionList[0].filename}`;
        const yearPlanPath = `/uploads/${societyYearPlan[0].filename}`;
        const budgetPath = `/uploads/${societyBudget[0].filename}`;
        const paymentPath = `/uploads/${societyPayment[0].filename}`;

        const society = await userService.registerSociety(
            societyName,
            societyDescription,
            department,
            iconPath,
            constitutionPath,
            executiveListPath,
            petitionListPath,
            yearPlanPath,
            budgetPath,
            paymentPath
        );

        res.json({ success: 'Society Successfully Registered.', society});
    } catch (error) {
        next(error); 
    }
};



exports.profile = async (req, res) => {
    try {
        const {userID, gender, race, religion, hobbies, age, campus } = req.body;
        const proofOfReg = req.file; 

        if (!proofOfReg) {
            return res.status(400).json({ error: 'Proof of registration file is missing.' });
        }

        const proofOfRegPath = path.join(__dirname, '../uploads/', proofOfReg.filename);

        const feedback = await userService.profile(userID, gender, race, proofOfRegPath, religion, hobbies, age, campus);
        res.json({ message: 'The profile has been created successfully', data: feedback });

    } catch (error) {
        console.error('Error during processing the profile', error);
        res.status(500).json({ error: 'Service error' });
    }
};





exports.getAllNotifications = async (req, res, next) => {
    try {
        const notifications = await userService.getAllNotifications();  

        res.status(200).json(notifications);
    } catch (error) {
        console.error('Error retrieving all notifications:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}

exports.getAllSocieties = async (req, res, next) => {
    try {
        const societies = await userService.getAllSocieties();  

        res.status(200).json(societies);
    } catch (error) {
        console.error('Error retrieving all societies:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}



exports.uploadMinutes=async (req, res, next)=>{
    try{
        const {societyID,meetingTitle, meetingDate,Venue,minutes}= req.body;
        await userService.uploadMinutes(societyID,meetingTitle, meetingDate,Venue,minutes);
        res.json({nextStatus: true , success: "Minutes Successfully Uploaded."})

    }catch(err){
        next (err);
    }
}

exports.uploadAgenda=async (req, res, next)=>{
    try{
        const {societyID, meetingTitle, meetingDate,meetingTime,Venue,agenda}= req.body;
        await userService.uploadAgenda(societyID,meetingTitle, meetingDate,meetingTime,Venue,agenda);
        res.json({nextStatus: true , success: "Agenda Successfully Uploaded."})

    }catch(err){
        next (err);
    }
}

exports.appEvent=async (req, res, next)=>{
    try{
        const {societyID, eventName, eventDate,eventType,eventDescription,preferredVenue,preferredTransport,eventAmount}= req.body;
        await userService.appEvent(societyID, eventName, eventDate,eventType,eventDescription,preferredVenue,preferredTransport,eventAmount);
        res.json({nextStatus: true , success: "Event Application Successfully Uploaded."})

    }catch(err){
        next (err);
    }
}


exports.joinSociety=async (req, res, next)=>{
    try{
        const {societyID,studentNumber,studentName, studentSurname, Age, Religion,Race}= req.body;
        await userService.joinSociety(societyID,studentNumber,studentName, studentSurname, Age, Religion,Race);
        res.json({nextStatus: true , success: "Application Successfully submitted."})

    }catch(err){
        next (err);
    }
}


exports.uploadFunds=async (req, res, next)=>{
    try{
        const {societyAccountID,eventName,Edate,eventType, EventDescription, amount}= req.body;
        await userService.uploadFunds(societyAccountID,eventName,Edate,eventType, EventDescription, amount);
        res.json({nextStatus: true , success: "Minutes Successfully Uploaded."})

    }catch(err){
        next (err);
    }
}

exports.requestItems = async (req, res, next) => {
    try {
        const { eventName, eventDate, eventType, eventDescription, itemsNeeded, estimateAmount } = req.body;
        await userService.requestItems(eventName, eventDate, eventType, eventDescription, itemsNeeded, estimateAmount);
        res.json({ success: "Funds Request Successfully Submitted." });
    } catch (err) {
        next(err);
    }
}
//noticeID was missing.
exports.uploadNotice = async (req, res, next) => {
    try {
        const {societyID } = req.params;
        const { title, content, created_at } = req.body;
        await userService.uploadNotice( societyID, title, content, created_at );
        res.json({ success: "Notice Updated." });
    } catch (err) {
        next(err);
    }
}

exports.uploadNoticeM = async (req, res, next) => {
    try {
        const userID = req.params.userID;
        const societyID = req.params.societyID;
        const { title, content, created_at } = req.body;
        
        // Validate input data if necessary
        
        // Call the service method with the required parameters
        await userService.uploadNotice(userID, societyID, title, content, created_at);
        res.json({ success: "Notice Added." });
    } catch (err) {
        next(err);
    }
};


exports.getNotice = async (req, res, next) => {
    try{
        const { societyID } = req.params;
        const notices = await userService.getNotices(societyID);
        res.json(notices);
    }
    catch(error)
    {
        next(error);
    }
}


exports.createRequirementss = async (req, res, next) => {
   
    try{

        const { societyID, requirementsType, reqDescription, requiresDoc} = req.body;
        //Adding the requirement to also get the ID of the requirement
        const requirementsID = await userService.addRequirement(requirementsType, reqDescription, requiresDoc);


        if(societyID && societyID.trim() !== '')
        {
            const result = await userService.addSocietyRequirements(societyID, requirementsID);
            console.log('Result of adding society requirement:', result);
        }

       

        res.json({ success: "Requirements have been successfully created!." });
    } 
    catch (error)
     {
        next(error);
    }
}





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

        const filePath = path.join(__dirname, '../uploads/', file.filename);

        const documentID = await userService.saveDocument(userID ,filePath);

        await userService.linkDocRequirement_M(requirementsID, documentID);

        res.json({
            success: 'Documents have been uploaded and linked to the requirement successfully'
        });



    }
    catch(error)
    {
        next(error);
    }
}


exports.getIcon = async (req, res, next) => {
    try {
        const { societyID } = req.params;
        const icon = await userService.getIcon(societyID);

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




exports.requestSociety=async (req, res, next)=>{
    try{
        const {userID, societyID,requestStatus, requestDate}= req.body;
        await userService.requestSociety(userID, societyID,requestStatus, requestDate);
        res.json({nextStatus: true , success: "Application Successfully submitted."})

    }catch(err){
        next (err);
    }
}

exports.getRequests = async (req, res, next) => {
    try{
        const { societyID } = req.params;
        const requests = await userService.getRequests(societyID);
        res.json(requests);
    }
    catch(error)
    {
        next(error);
    }
}

exports.updateStatus = async (req, res, next) =>{
    
        const {requestID} = req.params;
        const {requestStatus} = req.body;

        if(!['approved', 'declined'].includes(requestStatus)){
            return res.status(400).json({message: 'Invalid status'});

        }
    try{
        const result = await userService.updateStatus(requestID, requestStatus);
        res.status(200).json(result);
    }catch(error)
    {
        throw error;
    }
}


exports.getProfile_M = async (req, res) => {
    try {
        const { userID } = req.params;

        if (!userID) {
            return res.status(400).json({ error: 'User ID is missing.' });
        }

        const profile = await userService.getProfile(userID);
        if (!profile) {
            return res.status(404).json({ error: 'Profile not found.' });
        }

        res.json({ message: 'Profile retrieved successfully', data: profile });
    } catch (error) {
        console.error('Error during retrieving the profile', error);
        res.status(500).json({ error: 'Service error' });
    }
};

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




//================================================New API================================
exports.registerUser_M = async (req, res) => {
    try
    {
        const { studentN,  name, surname, email, password} = req.body;
        console.log('Received data:', req.body);
        
        //Calling our service function.
        const result = await userService.registerUser(studentN, name ,surname, email, password)
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


exports.changeUserRoles_M = async (req, res) =>
        {
        try
        {
            const {userID, roleName} = req.body;
            const result = await userService.changeUserRole(userID, roleName);

            if(result)
            {
                res.status(200).json({message: 'User role updated successfully'});

            }
            else
            {
                res.status(400).json({message: 'Failed to update the user role'});

            }

        }
        catch(error)
        {
            console.log('Error during role updating');
            throw error;
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



    exports.registerSocietyN_M = async (req, res, next) => {
        try {
            const { societyName, societyDescription, department, chairperson, treasurer, secretary, societyStatus = 'Pending' } = req.body;
            const { societyIcon, societyConstitution, societyExecutiveList, societyPetitionList, societyYearPlan, societyBudget, societyPayment } = req.files;
    
            if (!societyIcon || !societyConstitution || !societyExecutiveList || !societyPetitionList || !societyYearPlan || !societyBudget || !societyPayment) {
                return res.status(400).json({ error: 'One or more required files are missing.' });
            }
    
            const iconPath = `/uploads/${societyIcon[0].filename}`;
            const constitutionPath = `/uploads/${societyConstitution[0].filename}`;
            const executiveListPath = `/uploads/${societyExecutiveList[0].filename}`;
            const petitionListPath = `/uploads/${societyPetitionList[0].filename}`;
            const yearPlanPath = `/uploads/${societyYearPlan[0].filename}`;
            const budgetPath = `/uploads/${societyBudget[0].filename}`;
            const paymentPath = `/uploads/${societyPayment[0].filename}`;
    
            const society = await userService.registerSocietyN_M(
                societyName,
                societyDescription,
                department,
                chairperson,
                treasurer, 
                secretary,
                iconPath,
                constitutionPath,
                executiveListPath,
                petitionListPath,
                yearPlanPath,
                budgetPath,
                paymentPath,
                societyStatus
            );
    
            res.json({ success: 'Society Successfully Registered.', society});
        } catch (error) {
            next(error); 
        }
    };


    

    exports.approveSociety_M = async (req, res) => {
        const { societyID } = req.body;
    
        try {
            const result = await userService.approveSociety(societyID);

            res.status(200).json(result);
        } catch (error) {
            console.error('Error approving society:', error);
            res.status(500).json({ message: 'Failed to approve society' });
        }
    };

    exports.createRequirement_M = async (req, res) =>
    {
        try
        {
            console.log('Received request body: ', req.body);
            console.log('Received societyID: ', req.params.societyID);



            const {requirementsType, reqDescription, requiresDoc} = req.body;
            const societyID = req.params.societyID;
       
            const requirementsID = await userService.addRequirement(requirementsType, reqDescription, requiresDoc);

            console.log('Requirements created with ID: ', requirementsID);

            console.log('Requirements created with ID: ',requirementsID );
            //Linking the society and the requirement, if this society exists.
            if (societyID && societyID.trim() !== '') {
                const societyResult = await userService.addSocietyRequirements(societyID, requirementsID);
                console.log('Society reuqirement linked: ', societyResult);
            }
            res.json({success:'Requirement created successfully'});

        }
        catch(error)
        {
            console.error('Error in createRequirement:', error);
            res.status(500).json({error: 'Failed to create requirement'});
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

    exports.getPendingSociety_M = async (req, res) =>
    {
        try
        {
            const societies = await userService.getApprovedSociety();  

            res.status(200).json(societies);

        }
        catch(error)
        {
            res.error;
        }
    }

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

        await userService.saveText(requirementsID, userID, textValue);
        res.json({success: 'Text field data has been submitted successfully'});
        }
        catch(error)
        {
            next(error);
        }
    }
    
    exports.getSubmission_M = async (req, res, next) =>
    {
        const {userID, societyID} = req.params;
        console.log(`Fetching submissions for userID: ${userID} and societyID: ${societyID}`);
        try
        {
            const submissions = await userService.getSubmissions(userID, societyID);
            console.log('Submissions:', submissions);
            res.json(submissions);
            
        }
        catch(error)
        {
            console.error('Error fetching the submissions:', error);
            next(error);
        }
    }

    exports.approveUser_M = async (req, res) =>
    {
        const {userID, societyID} = req.params;

        try
        {
            await userService.approveUser_M(userID, societyID);
            res.json({message: 'User approved and the user has been added to the society'});
        }
        catch(error)
        {
            console.error('Error approving user:', error);
            throw error;
        }
    }

    exports.categoryReport = async (req, res) =>
    {
        try
        {
            const categoryData = await userService.categoryPercentage();
            res.json({categoryData});
        }
        catch(error)
        {
            console.error('Error fetching the categories', error);
            throw error;
        }

    }


    exports.inactiveReport = async (req, res) =>
    {
        try
        {
            const inactiveData = await userService.societyInactivePercentage();
            res.json({inactiveData});
        }
        catch(error)
        {
            console.error('Error fetching the students that left the societies.', error);
            throw error;
        }

    }

    exports.reasonForleavingReport = async (req, res) =>
    {
        try
        {
            const { societyID } = req.params;
            const reasonForLeaving = await userService.reasonForLeavingPercentage(societyID);
            res.json({reasonForLeaving});
        }
        catch(error)
        {
            console.error('Error fetching the reasons for leaving society', error);
            throw error;
        }

    }

    exports.attendanceReport = async (req, res) =>
    {
        try
        {
            const { societyID } = req.params;
            const attendance = await userService.attendanceReport(societyID);
            res.json({attendance});
        }
        catch(error)
        {
            console.error('Error fetching the students that were available in the event', error);
            throw error;
        }

    }

    exports.budgetReport = async (req, res) =>
        {
            try
            {
                const { societyID } = req.params;
                const budget = await userService.budgetReport(societyID);
                res.json({budget});
            }
            catch(error)
            {
                console.error('Error fetching the allocated funds versus the amount reised', error);
                throw error;
            }
    
        }








  

//Extra functionalities

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


    //Searching society name 
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


 //Filtering for web
 exports.filterSocietyASC_M = async (req, res) =>
 {
    try
        {
            const societies  = await userService.filterSocietiesASC_M();
            res.json({societies});
        }
        catch(error)
        {
            console.error('Error fetching ascending societies ', error);
            throw error;
        }

 }
    
 exports.filterSocietyDESC_M = async (req, res) =>
{
    try
        {
            const societies  = await userService.filterSocietiesDESC_M();
            res.json({societies});
        }
        catch(error)
        {
            console.error('Error fetching descending societies ', error);
            throw error;
        }

}

exports.filterEventByDateDESC_M = async (req, res) =>
{
    try
        {
            const events  = await userService.filterEventsByDateDESC_M();
            res.json({events});
        }
        catch(error)
        {
            console.error('Error fetching descending societies ', error);
            throw error;
        }

}

exports.filterEventBySocietyASC_M = async (req, res) =>
{
    try
    {
        const events  = await userService.filterEventsBySocietyASC_M();
        res.json({events});
    }
    catch(error)
    {
        console.error('Error fetching ascending societies ', error);
        throw error;
    }

}

exports.filterEventBySocietyDESC_M = async (req, res) =>
{
    try
        {
            const events  = await userService.filterEventsBySocietyDESC_M();
            res.json({events});
        }
        catch(error)
        {
            console.error('Error fetching descending societies ', error);
            throw error;
        }

}

exports.filterMinutesBySocietyDESC_M = async (req, res) =>
    {
        try
            {
                const minutes  = await userService.filterMinutesBySocietyDESC_M();
                res.json({minutes});
            }
            catch(error)
            {
                console.error('Error fetching descending minutes ', error);
                throw error;
            }
    
    }

exports.filterMinutesBySocietyASC_M = async (req, res) =>
{
    try
        {
            const minutes  = await userService.filterMinutesBySocietyASC_M();
            res.json({minutes});
        }
        catch(error)
        {
            console.error('Error fetching ascending societies ', error);
            throw error;
        }

}


exports.filterMinutesByDateDESC_M = async (req, res) =>
{
try
    {
        const minutes  = await userService.filterMinutesByDateDESC_M();
        res.json({minutes});
    }
    catch(error)
    {
        console.error('Error fetching descending minutes ', error);
        throw error;
    }

}

exports.filterMinutesByDateASC_M = async (req, res) =>
{
try
    {
        const events  = await userService.filterMinutesByDateASC_M();
        res.json({events});
    }
    catch(error)
    {
        console.error('Error fetching descending members ', error);
        throw error;
    }

}

exports.filterMemberByNameASC_M = async (req, res) =>
{
    try
        {
            const member  = await userService.filterMemberByNameASC_M();
            res.json({member});
        }
        catch(error)
        {
            console.error('Error fetching ascending members ', error);
            throw error;
        }

}
exports.filterMemberByNameDESC_M = async (req, res) =>
{
    try
    {
        const member  = await userService.filterMemberByNameDESC_M();
        res.json({member});
    }
    catch(error)
    {
        console.error('Error fetching ascending members ', error);
        throw error;
    }

}


exports.getNotifications_M = async (req, res, next) => {
    const userID = req.params.userID;
    if (!userID) {
        return res.status(400).json({ message: 'User ID is required' });
    }
    try {
        const notifications = await userService.getNotifications_M(userID);
        res.json(notifications);
    } catch (error) {
        console.error("Notifications can't be fetched:", error);
        res.status(500).json({ message: 'Encountered an error when fetching notifications' });
    }
};
<<<<<<< HEAD:backend/SocietyManagementApi/Controller/userControler.js

//////================================STATEMENTS=========================
=======
*/
>>>>>>> 1d879125cd14ee14e2dc7d92bbb6f9122aaa59b3:backend/SocietyManagementApi/Controller/user.controller.js

exports.filterBudgetByDateASC_M = async (req, res) =>
    {
        try
        {
            const budget  = await userService.filterBudgetByDateASC_M();
            res.json({budget});
        }
        catch(error)
        {
            console.error('Error fetching ascending budget by date ', error);
            throw error;
        }
    
    }
    exports.filterBudgetByDateDESC_M = async (req, res) =>
    {
        try
        {
            const member  = await userService.filterBudgetByDateDESC_M();
            res.json({member});
        }
        catch(error)
        {
            console.error('Error fetching descending budget by date ', error);
            throw error;
        }
    
    }
    
    exports.filterBudgetByTitleASC_M = async (req, res) =>
    {
        try
        {
            const budget  = await userService.filterBudgetByTitleASC_M();
            res.json({budget});
        }
        catch(error)
        {
            console.error('Error fetching ascending budget by title ', error);
            throw error;
        }
    
    }
    exports.filterBudgetByTitleDESC_M = async (req, res) =>
    {
        try
        {
            const member  = await userService.filterBudgetByTitleDESC_M();
            res.json({member});
        }
        catch(error)
        {
            console.error('Error fetching descending budget by title ', error);
            throw error;
        }
    
    }
    
    exports.filterBudgetByFundsRaisedASC_M = async (req, res) =>
    {
        try
        {
            const budget  = await userService.filterBudgetByFundsRaisedASC_M();
            res.json({budget});
        }
        catch(error)
        {
            console.error('Error fetching ascending budget by funds raised ', error);
            throw error;
        }
    
    }
    exports.filterBudgetByFundsRaisedDESC_M = async (req, res) =>
    {
        try
        {
            const member  = await userService.filterBudgetByFundsRaisedDESC_M();
            res.json({member});
        }
        catch(error)
        {
            console.error('Error fetching descending budget by funds raised ', error);
            throw error;
        }
    
    }
    
    exports.filterBudgetByAmountAllocatedASC_M = async (req, res) =>
    {
        try
        {
            const budget  = await userService.filterBudgetByAmountAllocatedASC_M();
            res.json({budget});
        }
        catch(error)
        {
            console.error('Error fetching ascending budget by amount Allocated ', error);
            throw error;
        }
    
    }
    exports.filterBudgetByAmountAllocatedDESC_M = async (req, res) =>
    {
        try
        {
            const member  = await userService.filterBudgetByAmountAllocatedDESC_M();
            res.json({member});
        }
        catch(error)
        {
            console.error('Error fetching descending budget by amount allocated ', error);
            throw error;
        }
    
    }