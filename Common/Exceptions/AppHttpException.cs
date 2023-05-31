using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Exceptions
{
    /// <summary>
    /// Exception for an Internet connection problem or a problem with the HttpClient class. This class extends the base AppException class.
    /// </summary>
    public class AppHttpException : AppException
    {
        /// <summary>
        /// Constructor of the exception.
        /// </summary>
        /// <param name="message">The message of the exception</param>
        /// <param name="errorData">The errorData of the exception</param>
        public AppHttpException(string message, string errorData = null) 
            : base(message, errorData) { }
    }
}
