using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BU.Entities
{
    /// <summary>
    /// Service execution result without return data
    /// </summary>
    public class ServiceResult
    {
        public ServiceResultStatus Status { get; set; }
        public StandardErrorCode? ErrorCode { get; set; }
        public string? Message { get; set; }
        public ImageBox ImageBox { get; set; }

    }

    public class ServiceResult<TValue> : ServiceResult
    {
        /// <summary>
        /// Generic Data
        /// </summary>
        public TValue? Value { get; set; }
    }

    public enum ServiceResultStatus
    {
        UNKNOWN,
        OK,
        KO
    }

    public enum StandardErrorCode
    {
        GenericError,
        NotFound,
        AlreadyExist,
        BadInput
    }

    public enum ImageBox
    {
        Warning = 48,
        Information = 64
    }
}
