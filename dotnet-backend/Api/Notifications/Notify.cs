using System;
using System.Net;
using Newtonsoft.Json;
using RestSharp;
using WaterRecycling.Entities;

namespace WaterRecycling.Notifications
{
    public class Notify
    {
        public Notify()
        {
        }

        public void NotifyNewDevice(Device data)
        {

            string URLService = "https://fcm.googleapis.com/fcm/send";

            var client = new RestClient(URLService);
            var request = new RestRequest("", Method.POST);
                
            request.AddHeader("accept", "application/json");
            request.AddHeader("content-type", "application/json");
            request.AddHeader("Authorization", "key=AIzaSyBy1U-SDxnBi2UNCRJ0JpCtseiudwrEypY");


            /*
             * 
             * {
                  "notification":{
                    "title":"Notification title",  
                    "body": "Notification body",  
                    "sound":"default",
                    "click_action":"FCM_PLUGIN_ACTIVITY",
                    "icon":"fcm_push_icon"  
                  },
                  "data":{
                    "param1":"value1",
                    "param2":"value2"
                  },
                    "to":"/topics/marketing", 
                    "priority":"high", 
                    "restricted_package_name":"" 
                }
             * */
            string jsonToSend = JsonConvert.SerializeObject(new {
                notification = new {
                    title = "Dispositivo de reciclaje",  
                    body = "Dispositivo registrado correctamente",  
                    sound = "default",
                    click_action = "FCM_PLUGIN_ACTIVITY",
                },
                to = data.DeviceToken,
                priority = "high"
            });

            request.AddParameter("application/json; charset=utf-8", jsonToSend, ParameterType.RequestBody);
            request.RequestFormat = DataFormat.Json;


            IRestResponse response = client.Execute(request);
            if (!string.IsNullOrEmpty(response.ErrorMessage))
                throw new Exception(response.ErrorMessage);
            
            if (response.StatusCode.Equals(HttpStatusCode.BadRequest) || response.StatusCode.Equals(HttpStatusCode.InternalServerError))
                throw new Exception(response.Content);

            if (response.StatusCode.Equals(HttpStatusCode.OK))
            {
                //OK 
            } 
        }

        internal void NewEvent(Device data)
        {

            string URLService = "https://fcm.googleapis.com/fcm/send";

            var client = new RestClient(URLService);
            var request = new RestRequest("", Method.POST);
                
            request.AddHeader("accept", "application/json");
            request.AddHeader("content-type", "application/json");
            request.AddHeader("Authorization", "key=AIzaSyBy1U-SDxnBi2UNCRJ0JpCtseiudwrEypY");


            /*
             * 
             * {
                  "notification":{
                    "title":"Notification title",  
                    "body": "Notification body",  
                    "sound":"default",
                    "click_action":"FCM_PLUGIN_ACTIVITY",
                    "icon":"fcm_push_icon"  
                  },
                  "data":{
                    "param1":"value1",
                    "param2":"value2"
                  },
                    "to":"/topics/marketing", 
                    "priority":"high", 
                    "restricted_package_name":"" 
                }
             * */
            string jsonToSend = JsonConvert.SerializeObject(new {
                notification = new {
                    title = "Dispositivo de reciclaje",  
                    body = "Llenado en curso",  
                    sound = "default",
                    click_action = "FCM_PLUGIN_ACTIVITY",
                },
                to = data.DeviceToken,
                priority = "high"
            });

            request.AddParameter("application/json; charset=utf-8", jsonToSend, ParameterType.RequestBody);
            request.RequestFormat = DataFormat.Json;


            IRestResponse response = client.Execute(request);
            if (!string.IsNullOrEmpty(response.ErrorMessage))
                throw new Exception(response.ErrorMessage);
            
            if (response.StatusCode.Equals(HttpStatusCode.BadRequest) || response.StatusCode.Equals(HttpStatusCode.InternalServerError))
                throw new Exception(response.Content);

            if (response.StatusCode.Equals(HttpStatusCode.OK))
            {
                //OK 
            } 
        }
    }
}
