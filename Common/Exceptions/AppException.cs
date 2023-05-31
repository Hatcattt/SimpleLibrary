using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Exceptions
{
    /// <summary>
    /// Base exception class for the application.
    /// </summary>
    public class AppException : ApplicationException
    {
        public string ErrorData { get; set; }

        /// <summary>
        /// Constructor of the exception.
        /// </summary>
        /// <param name="message">The message of the exception</param>
        /// <param name="errorData">The errorData of the exception</param>
        public AppException(string message, string errorData = null!)
            : base(message)
        {
            this.ErrorData = errorData;
        }

        /// <summary>
        /// Constructor of the exception with an innerException if needed.
        /// </summary>
        /// <param name="message">The message of the exception</param>
        /// <param name="errorData">The errorData of the exception</param>
        /// <param name="innerException">The inner exception</param>
        public AppException(string message, System.Exception innerException, string errorData)
            :base (message, innerException)
        {
            this.ErrorData = errorData;
        }
    }
}
