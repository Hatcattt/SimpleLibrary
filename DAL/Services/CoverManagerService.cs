using BU.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Services
{
    public class CoverManagerService
    {
        public static bool CopyImageToDisk(CoverImage coverImage, string destination)
        {
            try
            {
                var dest = Path.Combine(Environment.CurrentDirectory + destination);
                File.Copy(coverImage.ImagePath, dest);
                return true;
            } catch (Exception e)
            {
                // LOOG e.Message
                return false;
            }
        }
    }
}
