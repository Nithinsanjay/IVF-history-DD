using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel.Channels;
using System.ServiceModel.Configuration;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;
using System.Web;

namespace OncologyEMR.DataClass
{
    public class ClientMessage : IClientMessageInspector
    {
        private const string USER_AGENT_HTTP_HEADER = "appUnitSelection";
        private string lUnitSelection;
        public ClientMessage(string appUnitSelection)
        {
            this.lUnitSelection = appUnitSelection;
        }
        public object BeforeSendRequest(ref System.ServiceModel.Channels.Message request, System.ServiceModel.IClientChannel channel)
        {
            HttpRequestMessageProperty httpRequestMessage;
            object httpRequestMessageObject;
            if (request.Properties.TryGetValue(HttpRequestMessageProperty.Name, out httpRequestMessageObject))
            {
                httpRequestMessage = httpRequestMessageObject as HttpRequestMessageProperty;
                if (string.IsNullOrEmpty(httpRequestMessage.Headers[USER_AGENT_HTTP_HEADER]))
                {
                    httpRequestMessage.Headers[USER_AGENT_HTTP_HEADER] = (HttpContext.Current.Session == null ? "" : ("" + HttpContext.Current.Session["UNITCODE"]).ToString());
                    if (request.Properties.ContainsKey(USER_AGENT_HTTP_HEADER))
                    {
                        request.Properties[USER_AGENT_HTTP_HEADER] = (HttpContext.Current.Session == null ? "" : ("" + HttpContext.Current.Session["UNITCODE"]).ToString());
                    }
                    else
                    {
                        request.Properties[HttpRequestMessageProperty.Name] = httpRequestMessage;
                    }
                }
            }
            else
            {
                httpRequestMessage = new HttpRequestMessageProperty();
                httpRequestMessage.Headers.Add(USER_AGENT_HTTP_HEADER, (HttpContext.Current.Session == null ? "" : ("" + HttpContext.Current.Session["UNITCODE"]).ToString()));
                request.Properties.Add(HttpRequestMessageProperty.Name, httpRequestMessage);
            }
            return null;
        }
        public void AfterReceiveReply(ref System.ServiceModel.Channels.Message reply, object correlationState)
        {

        }

    }
    public class HttpUserAgentEndpointBehavior : IEndpointBehavior
    {
        private string lUnitSelection;
        public HttpUserAgentEndpointBehavior(string userAgent)
        {
            this.lUnitSelection = HttpContext.Current.Session == null ? "" : ("" + HttpContext.Current.Session["UNITCODE"]).ToString();
        }
        #region IEndpointBehavior Members
        public void AddBindingParameters(ServiceEndpoint endpoint, System.ServiceModel.Channels.BindingParameterCollection bindingParameters)
        { }
        public void ApplyClientBehavior(ServiceEndpoint endpoint, System.ServiceModel.Dispatcher.ClientRuntime clientRuntime)
        {
            ClientMessage inspector = new ClientMessage(this.lUnitSelection);
            clientRuntime.MessageInspectors.Add(inspector);
        }
        public void ApplyDispatchBehavior(ServiceEndpoint endpoint, System.ServiceModel.Dispatcher.EndpointDispatcher endpointDispatcher)
        { }
        public void Validate(ServiceEndpoint endpoint)
        { }
        #endregion
    }
    public class HttpUserAgentBehaviorExtensionElement : BehaviorExtensionElement
    {
        public override Type BehaviorType
        {
            get
            {
                return typeof(HttpUserAgentEndpointBehavior);
            }
        }
        protected override object CreateBehavior()
        {
            return new HttpUserAgentEndpointBehavior(UnitSelection);
        }
        [ConfigurationProperty("appUnitSelection", IsRequired = true)]
        public string UnitSelection
        {
            get { return (string)base["appUnitSelection"]; }
            set { base["appUnitSelection"] = value; }
        }

    }
}