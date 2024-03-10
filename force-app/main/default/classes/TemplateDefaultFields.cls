public without sharing class TemplateDefaultFields {

    public interface FieldDefaults { 
        Map<String, Object> getFieldDefaults();
    }
    
    public class AccountDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'Test Account'
            };
        }
    }

    public class AutomationSettingsDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'IsDisabled__c' => false
            };
        }
    }
}