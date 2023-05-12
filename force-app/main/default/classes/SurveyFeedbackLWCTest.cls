//Salesforce Unit Tests
@isTest
private class SurveyFeedbackLWCTest {
    static testMethod void testSaveSurveyResponse() {
        //Create test data
        Survey_Questions__c testQuestion = new Survey_Questions__c(
            Question_Type__c = 'text',
            Question__c = 'What is your name?'
        );
        insert testQuestion;
        List<Survey_Question_Choices__c> testAnswers = new List<Survey_Question_Choices__c>{
            new Survey_Question_Choices__c(
                Choice__c = 'John',
                Survey_Question__c = testQuestion.Id
            ),
            new Survey_Question_Choices__c(
                Choice__c = 'Paul',
                Survey_Question__c = testQuestion.Id
            )
        };
        insert testAnswers;
        
        //Run test
        Test.startTest();
        SurveyFeedbackLWC surveyFeedbackLWC = new SurveyFeedbackLWC();
        surveyFeedbackLWC.saveSurveyResponse();
        Test.stopTest();
        
        //Verify results
        List<Survey_Response__c> surveyResponses = [SELECT Id, Survey_Question__c, Response__c FROM Survey_Response__c];
        System.assertEquals(2, surveyResponses.size());
        for(Survey_Response__c response : surveyResponses) {
            System.assertEquals(testQuestion.Id, response.Survey_Question__c);
            System.assert(testAnswers.contains(response.Response__c));
        }
    }
}