using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ServiceModel;
using System.Configuration;

namespace OncologyEMR.DataClass
{
    public static class ServiceClient 
    {
        /// <summary>
        /// Release safely your WCF Client
        /// </summary>
        public static void UsingSafe<T>(this T client, Action<T> work) where T : ICommunicationObject
        {
            try
            {
                work(client);
            }
            finally
            {
                try
                {
                    client.Close();
                }
                catch (CommunicationException)
                {
                    client.Abort();
                }
                catch (TimeoutException)
                {
                    client.Abort();
                }
                catch (Exception)
                {
                    client.Abort();
                    throw;
                }
                ((IDisposable)client).Dispose();
            }

        }
    }


}