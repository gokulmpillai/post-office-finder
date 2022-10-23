import { LightningElement, track } from 'lwc';
import getPostOffice from '@salesforce/apex/IndianPostal.fetchPostOfficeByPin';
import getPostOfficeByCity from '@salesforce/apex/IndianPostal.fetchPostOfficeByCity';

const columns = [
    { label: 'Branch Type', fieldName: 'BranchType' },
    { label: 'Circle', fieldName: 'Circle' },
    { label: 'Country', fieldName: 'Country'},
    { label: 'Delivery Status', fieldName: 'DeliveryStatus' },
    { label: 'District', fieldName: 'District' },
    { label: 'Division', fieldName: 'Division' },
    { label: 'Name', fieldName: 'Name'},
    { label: 'Region', fieldName: 'Region' },
    { label: 'State', fieldName: 'State' },
];

export default class PostOfficeLocator extends LightningElement {
    pincode;
    result;
    columns = columns;
    isLoading = false;
    // @track data=[]; 

    pinCodeHandler(event){
        this.pincode = event.target.value;
    }
    
    viewPostOffice(){
        this.isLoading=true;
        getPostOffice({pincode : this.pincode}).then(response => {
            this.result = response;
            console.log('**********RESPONSE*******', response);
            this.isLoading=false;
        }).catch(error=>{
            console.log('**********ERROR**********', error.body.message);
            this.isLoading=false;
        })
    }

}