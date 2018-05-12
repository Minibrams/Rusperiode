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

        public static List<RelativePair> CountRelativeSameMembers(List<Team> teams)
        {
            List<RelativePair> relativeSameMembers = new List<RelativePair>();

            for (int i = 0; i < teams.Count; i++)
            {
                for (int j = i + 1; j < teams.Count - 1; j++)
                {
                    List<RelativePair> relatives = new List<RelativePair>();
                    foreach (Member member in teams[i].Members)
                    {
                        var newMemberArr = teams[i].Members.Where(x => x.relation.NewTeam == member.relation.NewTeam).ToList();
                        var oldMemberArr = teams[j].Members.Where(x => x.relation.NewTeam == member.relation.NewTeam).ToList();

                        // More than one means duplicates, less than one means no relation. Duplicates handled elsewhere.
                        if (newMemberArr.Count != 1 || oldMemberArr.Count != 1)
                            continue;

                        var pair = new RelativePair(newMemberArr.First(), oldMemberArr.First());
                        relatives.Add(pair);

                        if (oldMemberArr.Count() > 0)
                        { }
                    }

                    if (relatives.Count > 1)
                    {
                        relativeSameMembers.AddRange(relatives);
                    }
                }
            }
            return relativeSameMembers;
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

        public static void PrintRelativeSameTeams(List<RelativePair> relatedMembers)
        {
            Console.WriteLine("The following teams have a relation - members from old teams being paired and placed in the same new group.");
            for (int i = 0; i < relatedMembers.Count; i++)
            {
                if (i == 0 || relatedMembers[i].FirstMember.relation.OldTeam != relatedMembers[i - 1].FirstMember.relation.OldTeam)
                {
                    Console.Write($"From teams: {relatedMembers[i].FirstMember.relation.OldTeam}");
                    Console.WriteLine($" and {relatedMembers[i].SecondMember.relation.OldTeam}");
                }

                Console.WriteLine($"There is a relation between {relatedMembers[i].FirstMember} and {relatedMembers[i].SecondMember}.");
            }
        }

        public static void PrintNumberOfRelativeSameTeams(List<RelativePair> relatedMembers)
        {
            Console.WriteLine($"There currently exists {relatedMembers.Count} pairs on related teams. ({relatedMembers.Count * 2} members involved)");
        }
    }
}
