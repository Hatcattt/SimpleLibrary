namespace WpfApp
{
    class WPFAppTitle
    {
        public const string TITLE = "SimpleLibrary";

        public string? Process { get; set; }

        public override string? ToString()
        {
            return TITLE + " - [ " + Process + " ]";
        }
    }
}
