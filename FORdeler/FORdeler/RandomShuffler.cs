using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FORdeler
{
    class RandomShuffler : IShuffler
    {
        Random rand = new Random();

        /// <summary>
        /// Will shuffle the teams a hundred times, and pick the best solution.
        /// </summary>
        /// <param name="teams"> Teams to be shuffled </param>
        /// <returns> The shuffled teams </returns>
        public List<Team> shuffle(List<Team> teams, List<TeamConstraint> teamSpecifications)
        {
            List<Team> bestShuffle = new List<Team>();
            int duplicates = int.MaxValue;
            int relatives = int.MaxValue;

            for (int i = 0; i < 100; i++)
            {
                TeamConstraint[] temporary = new TeamConstraint[teamSpecifications.Count];
                Array.Copy(teamSpecifications.ToArray(), temporary, teamSpecifications.Count);
                List<Team> shuffled = oneShuffle(teams, temporary.ToList());

                int newDuplicates = TeamTester.CountSameTeams(shuffled).Count;
                int newRelatives = TeamTester.CountRelativeSameMembers(shuffled).Count;

                if (newDuplicates < duplicates)
                {
                    bestShuffle = shuffled;
                    duplicates = newDuplicates;
                    relatives = newRelatives;
                } else if (newDuplicates == duplicates)
                {
                    if (newRelatives < relatives)
                    {
                        bestShuffle = shuffled;
                        duplicates = newDuplicates;
                        relatives = newRelatives;
                    }
                }

            }

            return bestShuffle;
        }

        private List<Team> oneShuffle(List<Team> teams, List<TeamConstraint> teamSpecifications)
        {
            List<Team> shuffledTeams = new List<Team>();

            foreach (TeamConstraint teamConstraint in teamSpecifications)
            {
                teamConstraint.team.Members.Clear();
            }

            foreach (Team team in teams)
            {
                foreach (Member member in team.Members)
                {
                    // Get a random team that this member will be given too
                    int nextTeam = rand.Next(teamSpecifications.Count);
                    TeamConstraint targetTeam = teamSpecifications[nextTeam];

                    // Add the member
                    targetTeam.team.Members.Add(member);

                    // If the team is full, we remove it from the list of available teams (by adding to the returned)
                    if (targetTeam.maxMembers == targetTeam.team.Members.Count)
                    {
                        shuffledTeams.Add(targetTeam.team);
                        teamSpecifications.Remove(targetTeam);
                        if (teamSpecifications.Count == 0)
                            break;
                    }
                }

                if (teamSpecifications.Count == 0)
                    break;
            }

            // Add the rest of the teams (these are not full)
            foreach (TeamConstraint teamConstraint in teamSpecifications)
            {
                shuffledTeams.Add(teamConstraint.team);
            }

            return shuffledTeams;
        }
    }
}
