using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BU.Entities
{
    /// <summary>
    /// Service execution result without return data.
    /// </summary>
    public class ServiceResult
    {
        public ServiceResultStatus Status { get; set; }
        public StandardErrorCode? ErrorCode { get; set; }
        public string? Message { get; set; }
        public ImageBox ImageBox { get; set; }

    }

    /// <summary>
    /// Service execution result with data.
    /// </summary>
    public class ServiceResult<TValue> : ServiceResult
    {
        /// <summary>
        /// Generic Data
        /// </summary>
        public TValue? Value { get; set; }
    }

    /// <summary>
    /// The state of the ServiceResult.
    /// </summary>
    public enum ServiceResultStatus
    {
        UNKNOWN,
        OK,
        KO
    }

    /// <summary>
    /// Errors code for the ServiceResult.
    /// </summary>
    public enum StandardErrorCode
    {
        GenericError,
        NotFound,
        AlreadyExist,
        BadInput
    }

    /// <summary>
    /// Image box value to display in a MessageBox.
    /// </summary>
    public enum ImageBox
    {
        Warning = 48,
        Information = 64
    }
}
