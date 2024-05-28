public without sharing class TemplateDefaultFields {

    public interface FieldDefaults { 
        Map<String, Object> getFieldDefaults();
    }
    
    public class AccountDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults(){
            return new Map<String, Object>{
                'Name' => 'Test Account'
            };
        }
    }

    public class Product2Defaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults(){
            return new Map<String, Object>{
                'Name' => 'Test Product',
                'IsActive' => true
            };
        }
    }

    public class OrderDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults(){
            return new Map<String, Object>{
                'EffectiveDate' => Date.today(),
                'Status' => 'Draft'
            };
        }
    }

    public class OrderItemDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults(){
            return new Map<String, Object>{};
        }
    }

    public class PricebookEntryDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults(){
            return new Map<String, Object>{};
        }
    }
}