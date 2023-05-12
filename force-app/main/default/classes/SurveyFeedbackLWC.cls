//Salesforce Apex Class 
public with sharing class SurveyFeedbackLWC {
    
    //SurveyQuestions Object
    public List<Survey_Questions__c> surveyQuestions {get; set;}
    //SurveyQuestionChoices Object
    public List<Survey_Question_Choices__c> surveyQuestionChoices {get; set;}
    //SurveyResponse Object
    public List<Survey_Response__c> surveyResponse {get; set;}
    
    public SurveyFeedbackLWC(){
        surveyQuestions = [SELECT Id, Question_Type__c, Question__c FROM Survey_Questions__c];
        surveyQuestionChoices = [SELECT Id, Choice__c, Survey_Question__c FROM Survey_Question_Choices__c];
        surveyResponse = [SELECT Id, Response__c FROM Survey_Response__c];
    }
    
    public void saveSurveyResponse(){
        //Loop through surveyQuestions and surveyQuestionChoices
        for(Survey_Questions__c q : surveyQuestions){
            List<Survey_Question_Choices__c> answers = new List<Survey_Question_Choices__c>();
            //Check the question type and get the answers
            if(q.Question_Type__c == 'text'){
                //Get the text answers
            } else if(q.Question_Type__c == 'single choice'){
                //Get the single choice answers
            } else if(q.Question_Type__c == 'multi choice'){
                //Get the multi choice answers
            } else if(q.Question_Type__c == 'rating'){
                //Get the rating answers
            }
            //Save the answers in surveyResponse object
            for(Survey_Question_Choices__c a : answers){
                Survey_Response__c response = new Survey_Response__c(
                    Survey_Question__c = q.Id,
                    Response__c = a.Choice__c
                );
                surveyResponse.add(response);
            }
        }
        //Insert all survey responses
        insert surveyResponse;
    }
}