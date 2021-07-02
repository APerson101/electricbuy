import axios from "axios";

/**
 *
 * @param request Map<String, dynamic> that would be used to make get requests
 * @returns
 */

export class axiosHelper {
   rewardHeaders={"Authorization":`Bearer TEST_e9d77f93319e52d7d416f11f08338749e7dc33a8ba1b07c1647f667b2e422014`};
  async getRewardRequest(url: string) {
    const result=await axios.get(url, {headers:this.rewardHeaders}).then
    ((value)=>{
      // console.log(value.data)
      return value.data;
    }).catch((error)=>{
      if (axios.isAxiosError(error)) {
        console.log(error.response?.data)
        return error.response?.data;
      }
    });
    return result;
  }

  async postGiftCard(url:string, body:any)
  {
const result=await axios.post(url,body, {headers:this.rewardHeaders}).then((res)=>{
  console.log(res.data)
  return res.data;
}).catch((error)=>{
  if (axios.isAxiosError(error)) {
    console.log(error.response?.data)
    return error.response?.data;
  }
});
return result;
  }
  async getRequest(url:string, headers:any)
  {
    console.log(url);
    const result=await axios.get(url,{headers:headers}).then
    ((value)=>{
      console.log(value.data);
      return value.data;
    }).catch((error)=>{
      if (axios.isAxiosError(error)) {
        console.log(error.response?.data)
        return error.response?.data;
      }
    });
    return result.data;
  }

    postRequest (request:any) {
    const body=JSON.stringify(request["body"]);
    const result=axios.post(request["url"],
        body, {params: request["params"], headers: request["headers"]}).then(
        (res)=>{
        console.log(res.data); 
        return res.data;
        }
    ).catch((error)=>{
      if (axios.isAxiosError(error)) {
        console.log(error.response?.data)
        return error.response?.data;
      }
    });
    return result;
  }

  putRequest(request:any)
  {
  const res=  axios.put(request["url"], request["body"],{headers:request["headers"], params:request["params"]}).then(
      (val)=>{return val.data}
    ).catch(
      (val)=>{ if(axios.isAxiosError(val)){console.log(val);return val.response?.data}}
    ); return res;
  }


  deleteResponse(request:any)
  {
    const result=axios.delete(request["url"],
        {headers: request["headers"]}).then(
        (res)=>{
        console.log(res.data); return res.data;
        }
    ).catch((error)=>{
      if (axios.isAxiosError(error)) {
        return error.response?.data;
      }
    });
    return result;
  }
  

}
