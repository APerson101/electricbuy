import * as functions from "firebase-functions";
import {axiosHelper} from "./axioshelper";
const as=new axiosHelper();
const key="7wqxlltzswew3b2bwg39nfhoq0d47imzky";

export const buyCredit=functions.https.onCall(async (request)=>{
    var product_code=request["body"]["product_code"]
    var phone=request["body"]["phone"]
    var amount=request["body"]["amount"]
    var config = {
        url: `https://mobileoneapp.com/api/v2/airtime/?api_key=${key}&product_code=${product_code}&phone=${phone}&amount=${amount}`,
      };
    const result=await as.postRequest(config)
    return result;
    
});


export const buyCable=functions.https.onCall(async (request)=>{
    var product_code=request["body"]["product_code"]
    var smartcard_number=request["body"]["smartcard_number"]
    var config = {
        url: `https://mobileoneapp.com/api/v2/tv/?api_key=${key}&product_code=${product_code}&smartcard_number=${smartcard_number}`,
      };
   const result=await   as.postRequest(config);
   return result;
    
});

export const verifyCustomer=functions.https.onCall(async (request)=>{
    var product_code=request["body"]["product_code"]
    var smartcard_number=request["body"]["smartcard_number"]
    var config = {
        url: `https://mobileoneapp.com/api/v2/tv/?api_key=${key}&smartcard_number=${smartcard_number}&product_code=${product_code}&task=verify`,
      };
   const result=await   as.postRequest(config);
   return result;
});

export const buyPower=functions.https.onCall(async (request)=>{
    var product_code=request["body"]["product_code"]
    var meter_number=request["body"]["meter_number"]
    var amount=request["body"]["amount"]
    var config = {
        url: `https://mobileoneapp.com/api/v2/electric/?api_key=${key}&product_code=${product_code}&meter_number=${meter_number}&amount=${amount}`
      };
   const result=await   as.postRequest(config);
   return result;
});


export const verifyMeter=functions.https.onCall(async (request)=>{
    var product_code=request["body"]["product_code"]
    var meter_number=request["body"]["meter_number"]
    console.log(request["body"])
    var config = {
        url: `https://mobileoneapp.com/api/v2/electric/?api_key=${key}&product_code=${product_code}&meter_number=${meter_number}&task=verify`
      };
   const result=await as.postRequest(config);
   return result;
});

export const getAvailableServices=functions.https.onCall(async (request)=>{
    var service_code=request["body"]["service_code"]
    var sub_service_code=request["body"]["sub_service_code"]
    var config = {
        url: `https://mobileoneapp.com/api/v2/others/get_available_services.php/?api_key=${key}&service_code=${service_code}&sub_service_code=${sub_service_code}`
      };
   const result=await   as.postRequest(config);
   return result;
});

export const getSubService=functions.https.onCall(async (request)=>{
    var service_code=request["body"]["service_code"]
    var config = {
        url: `https://cloud.swiftnetsms.com/api/v2/others/get_sub_services.php/?api_key=${key}&service_code=${service_code}`
      };
   const result=await   as.postRequest(config);
   return result;
});

