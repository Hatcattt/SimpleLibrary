using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Exceptions
{
    /// <summary>
    /// Exception for null objects passed as parameters. This class extends the base AppException class.
    /// </summary>
    public class AppNullArgException : AppException
    {
        /// <summary>
        /// Constructor of the exception.
        /// </summary>
        /// <param name="message">The message of the exception</param>
        /// <param name="errorData">The errorData of the exception</param>
        public AppNullArgException(string message, string errorData = null) 
            : base(message, errorData) { }
    }
}
