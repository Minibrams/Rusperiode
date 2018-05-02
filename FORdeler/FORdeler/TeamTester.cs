using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FORdeler
{
    static class TeamTester
    {

        public static List<Member> CountSameTeams(List<Team> teamList)
        {
            List<Member> allDuplicatedMembers = new List<Member>();
            foreach (Team team in teamList)
            {
                Dictionary<Team, int> duplicateCounter = new Dictionary<Team, int>();
                foreach (Member member in team.Members)
                {
                    List<Member> duplicatedMembers = new List<Member>();
                    duplicatedMembers.AddRange(team.Members.Where(x => x.relation.OldTeam == member.relation.OldTeam).ToList());

                    if (duplicatedMembers.Count > 1 && !allDuplicatedMembers.Contains(duplicatedMembers.First()))
                        allDuplicatedMembers.AddRange(duplicatedMembers);
                }
            }

            return allDuplicatedMembers;
        }

        public static void PrintSameTeams(List<Member> duplicateMembers)
        {
            Console.WriteLine("The following members are duplicated:");
            foreach (Member member in duplicateMembers)
            {
                Console.WriteLine($"On team {member.relation.NewTeam}: {member.Name} from team {member.relation.OldTeam}");
            }
        }

        public static void PrintNumberOfSameTeams(List<Member> duplicateMembers)
        {
            Console.WriteLine($"There currently exists {duplicateMembers.Count} members who share teams on both old and new.");
        }

        public static List<Member> CountRelativeSameMembers(List<>)
    }
}
