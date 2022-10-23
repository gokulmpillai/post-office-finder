public with sharing class IndianPostal {
    @AuraEnabled
    public static List<PostalResponseWrapper> fetchPostOfficeByPin(Integer pincode){
		//List to store the parsed JSON response
        List<PostalResponseWrapper> postalList = new List<PostalResponseWrapper>();
		//Constructing the request 
        String URL = 'https://api.postalpincode.in/pincode/';
        Http httpObj = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(URL+pincode);
        req.setMethod('GET');
        HttpResponse res = httpObj.send(req);
        System.debug(res.getBody());
		//Check if there is a success response from the postal pincode server
        if(res.getStatusCode()== 200){
            JSONParser parser = JSON.createParser(res.getBody());
			//use the jsonparser and jsontoken enum to navigate  through the token & deserialize the response
            parser.nextToken();
            while(parser.nextToken()!= NULL){
                if(parser.getCurrentToken() == JSONTOKEN.START_ARRAY){
                    while(parser.nextToken()!= NULL){
                        if(parser.getCurrentToken() == JSONTOKEN.START_OBJECT){
                            PostalResponseWrapper postalResponseObj = (PostalResponseWrapper)parser.readValueAs(PostalResponseWrapper.class);
                            postalList.add(postalResponseObj);
                            System.debug(postalResponseObj);
                            System.debug('********Postal List********' + postalList);
                        }
                    }
                }
            }
        }
        return postalList;
    }
    
    @AuraEnabled
    public static List<PostalResponseWrapper> fetchPostOfficeByCity(String City){
        List<PostalResponseWrapper> postOfficeList = new List<PostalResponseWrapper>();
        String URL = 'https://api.postalpincode.in/pincode/';
        Http http = new Http();
        HttpRequest hreq = new HttpRequest();
        hreq.setEndpoint(URL+City);
        hreq.setMethod('GET');
        HttpResponse hres = http.send(hreq);
        System.debug('******Response City********'+ hres.getBody());
        if(hres.getStatusCode()==200){
        	JSONParser jsonparser = JSON.createParser(hres.getBody());
        	jsonparser.nextToken();
        		while(jsonparser.nextToken() != NULL){
            		if(jsonparser.getCurrentToken() == JSONTOKEN.START_ARRAY){
                		while(jsonparser.nextToken() != NULL){
                    		if(jsonparser.getCurrentToken() == JSONTOKEN.START_OBJECT){
                        	PostalResponseWrapper eachPostal = (PostalResponseWrapper)jsonparser.readValueAs(PostalResponseWrapper.class);
                        	postOfficeList.add(eachPostal);
                    		}
                		}    
                	}            
            	}
        	}
        return postOfficeList;
    }

    public class PostalResponseWrapper{
        @AuraEnabled
        public String Name{get; set;}
        @AuraEnabled
        public String Description{get; set;}
        @AuraEnabled
        public String PINCode{get; set;}
        @AuraEnabled
        public String BranchType{get; set;}
        @AuraEnabled
        public String DeliveryStatus{get; set;}
        @AuraEnabled
        public String Circle{get; set;}
        @AuraEnabled
        public String District{get; set;}
        @AuraEnabled
        public String Division{get; set;}
        @AuraEnabled
        public String Region{get; set;}
        @AuraEnabled
        public String State{get; set;}
        @AuraEnabled
        public String Country{get; set;}
    }
}