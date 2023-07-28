global without sharing class UtilsClass {
    
    public static Id getRecordTypeId(String objectName, String recordType, Boolean isDeveloperName){

        try{
            if(isDeveloperName){
                return Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByDeveloperName().get(recordType).getRecordTypeId();
            }
            
            return Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByName().get(recordTypeDeveloperName).getRecordTypeId();
        }
        catch(Exception e){}

        return null;
    }

    public static Map<String, String> getPicklistValues(String objectName, String fieldName){

        Map<String, String> picklistValues = new Map<String, String>();

        try{
            Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().get(fieldName).getDescribe();

            for(Schema.PicklistEntry picklistEntry : fieldResult.getPicklistValues()){
                picklistValues.put(picklistEntry.getValue(), picklistEntry.getLabel());
            }
        }
        catch(Exception e){}

        return picklistValues;
    }

    public static Boolean isChanged(SObject newRecord, SObject oldRecord, String field){

        Boolean isChanged = false;

        try{
            isChanged = (newRecord.get(field) != oldRecord.get(field)) ? true : false;
        }
        catch(Exception e){}

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
        catch(Exception e){}

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
            responseWrapper.response.put('message', e.getMessage());
        }

        return responseWrapper;
    }

    public static void sendSingleEmail(List<String> toAddresses, List<String> ccAddresses, String body, Boolean isHtmlBody, String subject, String displayName, Boolean isBccSender, Boolean useSignature, String replyTo){

        Messaging.reserveSingleEmailCapacity(toAddresses.size() + ccAddresses.size());

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        if(toAddresses.size() + ccAddresses.size() = 0) return;

        mail.setToAddresses(toAddresses);
        mail.setCcAddresses(ccAddresses);

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

        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
    }
    
    public class HttpResponseWrapper {
        public Map<String, Object> response;
        public Integer statusCode;
        public Boolean hasError = false;
    }

}