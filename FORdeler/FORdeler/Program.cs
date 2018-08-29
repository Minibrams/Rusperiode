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

            Random rand = new Random();
            List<TeamConstraint> teamSpecifications = new List<TeamConstraint>();
            for (int i = 0; i < 20; i++)
            {
                teamSpecifications.Add(new TeamConstraint(i.ToString()) { maxMembers = rand.Next(5, 7) });
            }

            IShuffler shuffler = new RandomShuffler();

            List<Team> teams = shuffler.shuffle(loader.oldTeams, teamSpecifications);
            

            List<Member> duplicatedMembers = TeamTester.CountSameTeams(teams);
            List<RelativePair> relatedMembers = TeamTester.CountRelativeSameMembers(teams);

            TeamTester.PrintNumberOfSameTeams(duplicatedMembers);
            //TeamTester.PrintSameTeams(duplicatedMembers);
            TeamTester.PrintNumberOfRelativeSameTeams(relatedMembers);
            //TeamTester.PrintRelativeSameTeams(relatedMembers);

            Console.ReadKey();
        }
    }


}
