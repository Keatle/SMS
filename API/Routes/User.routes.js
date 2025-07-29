const express = require('express');
const router = express.Router();
const userController = require('../Controller/User.conteoller');
const upload = require('../Config/multer.js'); 


//===============================================================================M O B I L E ====================================
router.post('/registrationUser', userController.registerUser_M);
router.post('/signin', userController.signin_M);
router.get('/getRequirements/:societyID', userController.getRequirements_M);
router.post('/uploadDocument/:requirementsID/:userID', upload.single('file'), userController.uploadDocument_M);
router.get('/approvedSociety', userController.getApprovedSociety_M);
router.get('/approvedSociety', userController.getApprovedSociety_M);
router.get('/studentsociety/:userID', userController.getJoinedSociety_M);
router.get ('/notifications/:userID/:noticeFor', userController.getNotifications_M);
router.put('/readNotifications/:noticeID', userController.markNotificationAsRead_M);
router.post ('/leaveSociety/:societyID/:userID', userController.leaveSociety_M);
router.get('/getFullNames/:userID', userController.getUserNameSurname_M);
router.post('/sendOTP', userController.sendPasswordOTP_M);
router.post('/verifyOTP', userController.verifyOTP);
router.post('/resetPassword', userController.resetPassword);
router.get('/getIcon/:societyID', userController.getIcon_M);
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
router.post('/requests', userController.requestSociety_M);
router.get('/pendingSocieties/:userID', userController.getPendingSocietiesForUser_M);
router.get('/getBudgets/:userID', userController.getBudgetDetails_M);
router.get('/unreadCount/:userID', userController.countUnreadNotifications);


///SEARCHES
router.post('/searchSociety', userController.searchSocietyByName_M);
router.post('/searchSociety', userController.searchPendingSocietyByName_M);
router.post('/searchEvent', userController.searchEventByName_M);
router.post('/searchNotification', userController.searchNotificationByTitle_M);
router.post('/searchMinutes', userController.searchMinutesByTitle_M);

//WEb Filtering
router.get('/categorySociety/:department', userController.filterSocietyCategory);
router.get('/ascendingSociety', userController.filterSocietyASC_M);
router.get('/descendingSociety', userController.filterSocietyDESC_M);

//Events
router.get('/typeEvent/:eventType', userController.filterEventType);
router.get('/eventNameFilterASC', userController.filterEventByNameASC_M); 
router.get('/eventNameFilterDESC', userController.filterEventByNameDESC_M);
router.get('/eventDateFilterASC', userController.filterEventByDateASC_M);
router.get('/eventDateFilterDESC', userController.filterEventByDateDESC_M);
router.get('/eventSocietyFilterASC', userController.filterEventBySocietyASC_M); 
router.get('/eventSocietyFilterDESC', userController.filterEventBySocietyDESC_M);

//Minutes

router.get('/minutesSocietyFilterASC', userController.filterMinutesBySocietyASC_M); 
router.get('/minutesSocietyFilterDESC', userController.filterMinutesBySocietyDESC_M);
router.get('/minutesDateFilterASC', userController.filterMinutesByDateASC_M); 
router.get('/minutesDateFilterDESC', userController.filterMinutesByDateDESC_M);

//Members
router.get('/memberFilterASC', userController.filterMemberByNameASC_M); 
router.get('/memberFilterDESC', userController.filterMemberByNameDESC_M);

//statements
router.get('/budgetDateFilterASC/:timeRange/:societyID', userController.filterBudgetByDateASC_M);
router.get('/budgetDateFilterDESC', userController.filterBudgetByDateDESC_M);
router.get('/budgetTitleFilterASC', userController.filterBudgetByTitleASC_M);
router.get('/budgetTitleFilterDESC', userController.filterBudgetByTitleDESC_M);
router.get('/budgetFundsRaisedFilterASC', userController.filterBudgetByFundsRaisedASC_M);
router.get('/budgetFundsRaisedFilterDESC', userController.filterBudgetByFundsRaisedDESC_M);
router.get('/budgetAmountAllocatedFilterASC', userController.filterBudgetByAmountAllocatedASC_M);
router.get('/budgetAmountAllocatedFilterDESC', userController.filterBudgetByAmountAllocatedDESC_M);
router.post('/sendOTP_w', userController.sendOTPEmail_w);
router.post('/verifyOTP_w', userController.verifyOTP_w);
router.post('/resetPassword', userController.resetPassword);

router.put('/readNotifications/:noticeID', userController.markNotificationAsRead_M);
router.get('/countActiveMembersPerSocietyMonthly/:societyID', userController.countActiveMembersPerSocietyMonthly);




//=================================MObile===========================================
module.exports = router;
