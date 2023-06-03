using DAL;

namespace ConsoleApp
{
    /// <summary>
    /// Class used to lunch the program.
    /// </summary>
    public class Program
    {

        static async Task Main(string[] args)
        {
            string isbn = "9782800180083";

            var json = await DAL.Services.LibraryGoogleAgentService.GetJsonAsyncBy(isbn);
            var gBook = new BU.Entities.GoogleBookPublication(json);

            Console.WriteLine($"Isbn  : {gBook.Isbn}\nTitle : {gBook.Title}\nCover : {gBook.CoverFilePath}");
        }
    }
}