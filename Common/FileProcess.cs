using Microsoft.Extensions.Configuration;

namespace Common
{
    public class FileProcess
    {
        public static bool CopyImageToDisk(string imagePath, string destination)
        {
            try
            {
                File.Copy(imagePath, destination);
                return true;
            }
            catch (Exception e)
            {
                throw new Exception(e.ToString());
            }
        }
    }
}