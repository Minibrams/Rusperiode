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

            List<RelativePair> relatedMembers = TeamTester.CountRelativeSameMembers(loader.oldTeams);

            for (int i = 0; i < relatedMembers.Count; i++)
            {
                if (i == 0 || relatedMembers[i].FirstMember.relation.OldTeam != relatedMembers[i - 1].FirstMember.relation.OldTeam)
                {
                    Console.Write($"From teams: {relatedMembers[i].FirstMember.relation.OldTeam}");
                    Console.WriteLine($" and {relatedMembers[i].SecondMember.relation.OldTeam}");
                }

                Console.WriteLine($"There is a relation between {relatedMembers[i].FirstMember} and {relatedMembers[i].SecondMember}.");
            }

            Console.WriteLine();
            Console.ReadKey();
        }
    }


}
