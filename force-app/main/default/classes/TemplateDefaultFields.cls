public with sharing class TemplateDefaultFields {
    
    public class AccountDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'Test Account'
            };
        }
    }
}