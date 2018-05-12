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
            string oldTeamPath = AppDomain.CurrentDomain.BaseDirectory + "..\\..\\Testdata\\RuskursusgrupperOld.csv";
            string newTeamPath = AppDomain.CurrentDomain.BaseDirectory + "..\\..\\Testdata\\Ruskursusgrupper.csv";

            Loader loader = new Loader();
            loader.loadTwoBundles(oldTeamPath, newTeamPath);

            List<Member> duplicatedMembers = TeamTester.CountSameTeams(loader.newTeams);
            List<RelativePair> relatedMembers = TeamTester.CountRelativeSameMembers(loader.oldTeams);

            //TeamTester.PrintNumberOfSameTeams(duplicatedMembers);
            //TeamTester.PrintSameTeams(duplicatedMembers);
            TeamTester.PrintNumberOfRelativeSameTeams(relatedMembers);
            //TeamTester.PrintRelativeSameTeams(relatedMembers);

            Console.ReadKey();
        }
    }


}
