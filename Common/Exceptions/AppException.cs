using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Exceptions
{
    public class AppException : ApplicationException
    {
        public string ErrorData { get; set; }

        public AppException(string message, string errorData = null!)
            : base(message)
        {
            this.ErrorData = errorData;
        }

        public AppException(string message, System.Exception innerException, string errorData)
            :base (message, innerException)
        {
            this.ErrorData = errorData;
        }
    }
}
