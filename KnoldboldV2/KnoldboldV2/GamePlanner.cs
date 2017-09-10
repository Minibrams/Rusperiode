using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KnoldboldV2
{
    class GamePlanner
    {
        private List<Team> upper = new List<Team>();
        private List<Team> lower = new List<Team>();

        public GamePlanner(List<Team> teams) {
            if (teams.Count % 2 != 0) {
                teams.Add(new Team("DUMMY-HOLD - tag en pause"));
            }

            for (int i = 0; i < teams.Count / 2; i++) {
                upper.Add(teams[i]);
            }

            for (int i = teams.Count / 2; i < teams.Count; i++) {
                lower.Add(teams[i]);
            }
        }

        public Stack<Match> GenerateRound() {
            Stack<Match> toReturn = new Stack<Match>();
            for (int i = 0; i < upper.Count; i++) {
                toReturn.Push(new Match(upper[i], lower[i]));
            }
            RotateTeams();
            return toReturn;
        }

        private void RotateTeams() {
            upper.Insert(1, lower.First());
            lower.Add(upper.Last());
            lower.Remove(lower.First());
            upper.Remove(upper.Last());
        }
    }
}
