/*const express = require('express');
const router = express.Router();
const userController = require('../Controller/user.controller.js');
const upload = require('../Config/multer.js'); 


///=====================================NEW API======================================
router.post('/registrationUser', userController.registerUser_M);
router.put('/updateUserRole', userController.changeUserRoles_M);
router.post('/signin', userController.signin_M);
router.post('/regSocietyN', upload.fields([
    {name: 'societyIcon', maxCount: 1},
    {name: 'societyConstitution', maxCount: 1},
    {name: 'societyExecutiveList', maxCount: 1},
    {name: 'societyPetitionList', maxCount: 1},
    {name: 'societyYearPlan', maxCount: 1},
    {name: 'societyBudget', maxCount: 1},
    {name: 'societyPayment', maxCount: 1}

]), userController.registerSocietyN_M);
router.post('/approveSociety', userController.approveSociety_M);
router.post('/createReq/:societyID', userController.createRequirement_M);
router.get('/getRequirements/:societyID', userController.getRequirements_M);
router.post('/uploadDocument/:requirementsID/:userID', upload.single('file'), userController.uploadDocument_M);
router.get('/approvedSociety', userController.getApprovedSociety_M);
router.get('/getRequirements/:societyID', userController.getRequirements_M);
router.post('/submitText/:requirementsID/:userID', userController.submitText_M);
router.post('/approveUser/:userID/:societyID', userController.approveUser_M);
router.get('/getSubmissions/:userID/:societyID', userController.getSubmission_M);
router.get('/studentsociety/:userID', userController.getJoinedSociety_M);
router.get ('/notifications/:userID', userController.getNotifications_M);

//==================================REPORTING========================
router.get('/categoryReport', userController.categoryReport);
router.get('/inactiveReport', userController.inactiveReport);
router.get('/reasonReport/:societyID', userController.reasonForleavingReport);
router.get('/attendanceReport/:societyID', userController.attendanceReport);
router.get('/budgetReport/:societyID', userController.budgetReport);




//EXTRA FUNCTIONALITIES
router.get('/society/departments', userController.categorizeSocieties_M);

router.get('/societies/religious', userController.getReligiousSocieties_M);
router.get('/societies/academic', userController.getAcademicSocieties_M);
router.get('/societies/political', userController.getPoliticalSocieties_M);
router.get('/societies/sport', userController.getSportSocieties_M);
router.get('/societies/entertainment', userController.getEntertainmentSocieties_M);
router.get('/societies/culture', userController.getCultureSocieties_M);

///SEARCHES
router.post('/searchSociety', userController.searchSocietyByName_M);
router.post('/searchEvent', userController.searchEventByName_M);
router.post('/searchNotification', userController.searchNotificationByTitle_M);
router.post('/searchMinutes', userController.searchMinutesByTitle_M);

//WEb Filtering
router.get('/ascendingSociety', userController.filterSocietyASC_M);
router.get('/descendingSociety', userController.filterSocietyDESC_M);

//Events
router.get('/eventDateFilterASC', userController.filterEventByDateDESC_M);
router.get('/eventDateFilterDESC', userController.filterEventByDateDESC_M);
router.get('/eventSocietyFilterASC', userController.filterEventBySocietyASC_M); //The event table doesn't display the name of the society.
router.get('/eventSocietyFilterDESC', userController.filterEventBySocietyDESC_M);

//Minutes

router.get('/minutesSocietyFilterASC', userController.filterMinutesBySocietyASC_M); //The event table doesn't display the name of the society.
router.get('/minutesSocietyFilterDESC', userController.filterMinutesBySocietyDESC_M);
router.get('/minutesDateFilterASC', userController.filterMinutesByDateASC_M); //The event table doesn't display the name of the society.
router.get('/minutesDateFilterDESC', userController.filterMinutesByDateDESC_M);

//Members
router.get('/memberFilterASC', userController.filterMemberByNameASC_M); //The event table doesn't display the name of the society.
router.get('/memberFilterDESC', userController.filterMemberByNameDESC_M);


//statements
router.get('/budgetDateFilterASC', userController.filterBudgetByDateASC_M);
router.get('/budgetDateFilterDESC', userController.filterBudgetByDateDESC_M);
router.get('/budgetTitleFilterASC', userController.filterBudgetByTitleASC_M);
router.get('/budgetTitleFilterDESC', userController.filterBudgetByTitleDESC_M);
router.get('/budgetFundsRaisedFilterASC', userController.filterBudgetByFundsRaisedASC_M);
router.get('/budgetFundsRaisedFilterDESC', userController.filterBudgetByFundsRaisedDESC_M);
router.get('/budgetAmountAllocatedFilterASC', userController.filterBudgetByAmountAllocatedASC_M);
router.get('/budgetAmountAllocatedFilterDESC', userController.filterBudgetByAmountAllocatedDESC_M);


module.exports = router;
*/