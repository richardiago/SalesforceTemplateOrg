global without sharing class UtilsClass {

    public static Boolean verifyAutomationSetting(string objectAPIName){

        try{
            return AutomationSettings__c.getValues(objectAPIName).IsDisabled__c;
        }
        catch(Exception e){
            throw new UtilsException(e.getMessage());
        }
    }

    public static void setAutomationSetting(string objectAPIName, Boolean isDisabled){

        try{
            AutomationSettings__c automationSetting = AutomationSettings__c.getValues(objectAPIName);
            automationSetting.IsDisabled__c = isDisabled;
            update automationSetting;
        }
        catch(Exception e){
            throw new UtilsException(e.getMessage());
        }
    }
    
    public static Id getRecordTypeId(String objectName, String recordType, Boolean isDeveloperName){

        try{
            if(isDeveloperName){
                return Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByDeveloperName().get(recordType).getRecordTypeId();
            }
            
            return Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByName().get(recordType).getRecordTypeId();
        }
        catch(Exception e){
            throw new UtilsException(e.getMessage());
        }
    }

    public static Map<String, String> getPicklistValues(String objectName, String fieldName){

        Map<String, String> picklistValues = new Map<String, String>();

        try{
            Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().get(fieldName).getDescribe();

            for(Schema.PicklistEntry picklistEntry : fieldResult.getPicklistValues()){
                picklistValues.put(picklistEntry.getValue(), picklistEntry.getLabel());
            }
        }
        catch(Exception e){
            throw new UtilsException(e.getMessage());
        }

        return picklistValues;
    }

    public static Boolean isChanged(SObject newRecord, SObject oldRecord, String field){

        Boolean isChanged = false;

        try{
            isChanged = (newRecord.get(field) != oldRecord.get(field)) ? true : false;
        }
        catch(Exception e){
            throw new UtilsException(e.getMessage());
        }

        return isChanged;
    }

    public static Boolean isChanged(SObject newRecord, SObject oldRecord, List<String> fields){

        try{
            for(String field : fields){
                if(isChanged(newRecord, oldRecord, field)) return true;
            }
        }
        catch(Exception e){}

        return false;
    }

    public static String getObjectDeveloperName(Id recordId, Boolean isGettingDeveloperName){

        String objectName = '';

        try{
            objectName = isGettingDeveloperName ? recordId.getSObjectType().getDescribe().getName() : recordId.getSObjectType().getDescribe().getLabel();
        }
        catch(Exception e){
            throw new UtilsException(e.getMessage());
        }

        return objectName;
    }

    public static HttpResponseWrapper executeHttpRequest(String endpoint, String method, Object body, Map<String, String> headers){

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setTimeout(120000);

        if(body != null) request.setBody(JSON.serialize(body));

        for(String key : headers.keySet()){
            request.setHeader(key, headers.get(key));
        }

        HttpResponseWrapper responseWrapper = new HttpResponseWrapper();

        try{
            HttpResponse response = new Http().send(request);
            responseWrapper.statusCode = response.getStatusCode();
            responseWrapper.response = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        }
        catch(Exception e){
            responseWrapper.hasError = true;
            responseWrapper.response = new Map<String, Object>();
            responseWrapper.response.put('error', e.getMessage());
        }

        return responseWrapper;
    }

    public static void sendEmail(List<Messaging.SingleEmailMessage> emails){
    
        Messaging.sendEmail(emails, false);
    }

    public static Messaging.SingleEmailMessage buildEmail(List<String> toAddresses, List<String> ccAddresses, String body, Boolean isHtmlBody, String subject, String displayName, Boolean isBccSender, Boolean useSignature, String replyTo){

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        if(!toAddresses.isEmpty()) mail.setToAddresses(toAddresses);
        if(!ccAddresses.isEmpty()) mail.setCcAddresses(ccAddresses);

        if(String.isNotBlank(replyTo)) mail.setReplyTo(replyTo);
        if(String.isNotBlank(displayName)) mail.setSenderDisplayName(displayName);
        if(String.isNotBlank(subject)) mail.setSubject(subject);
        mail.setBccSender(isBccSender);
        mail.setUseSignature(useSignature);

        if(isHtmlBody){
            mail.setHtmlBody(body);
        }
        else{
            mail.setPlainTextBody(body);
        }

        return mail;
    }
    
    public class UtilsException extends Exception {}

    public class HttpResponseWrapper {
        public Map<String, Object> response;
        public Integer statusCode;
        public Boolean hasError = false;
    }
}