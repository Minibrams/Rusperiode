using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FORdeler
{
    class Program
    {
        static void Main(string[] args)
        {
            string oldTeamPath = AppDomain.CurrentDomain.BaseDirectory + "..\\..\\Testdata\\oldTeam.csv";
            string newTeamPath = AppDomain.CurrentDomain.BaseDirectory + "..\\..\\Testdata\\newTeam.csv";

            Loader loader = new Loader();
            loader.loadTwoBundles(oldTeamPath, newTeamPath);

            List<Member> duplicatedMembers = TeamTester.CountSameTeams(loader.newTeams);

            TeamTester.PrintDuplicates(duplicatedMembers);

            Console.WriteLine();
            Console.ReadKey();
        }
    }

    
}
