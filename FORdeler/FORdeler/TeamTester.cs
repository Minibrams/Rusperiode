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
                    duplicatedMembers.AddRange(team.Members.Where(x => x.OldTeam == member.OldTeam).ToList());

                    if (duplicatedMembers.Count > 1 && !allDuplicatedMembers.Contains(duplicatedMembers.First()))
                        allDuplicatedMembers.AddRange(duplicatedMembers);
                }
            }

            return allDuplicatedMembers;
        }

        public static void PrintDuplicates(List<Member> duplicateMembers)
        {
            Console.WriteLine("The following members are duplicated:");
            foreach (Member member in duplicateMembers)
            {
                Console.WriteLine($"On team {member.BelongingTeam.Name}: {member.Name} from team {member.OldTeam.Name}");
            }
        }
    }
}
