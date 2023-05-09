using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace WpfApp.Validation
{
    public class PublicationCreateRule : ValidationRule
    {
        public PublicationCreateRule() { }

        public override ValidationResult Validate(object value, CultureInfo cultureInfo)
        {
            string valueToValidate = value as string;
            if (valueToValidate.Length < 6 || valueToValidate.Length > 10)
            {
                return new ValidationResult(false, "Name should be between range 3-50");
            }

            return new ValidationResult(true, null);
        }
    }
}
