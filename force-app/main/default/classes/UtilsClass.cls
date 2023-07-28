public without sharing class UtilsClass {
    
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

}