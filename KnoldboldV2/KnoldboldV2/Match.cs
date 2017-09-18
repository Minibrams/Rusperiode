using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KnoldboldV2
{
    class Match
    {
        public Team T1, T2;

        public Match(Team t1, Team t2) {
            T1 = t1;
            T2 = t2;
        }

        public Match() {
            T1 = new Team("DUMMY-MATCH");
            T2 = new Team("DUMMY-MATCH");
        }

        public override string ToString() {
            return $"\"{T1}\" VS. \"{T2}\"";
        }

        /* Not really an Equals()... */
        public bool Matches(Match other) {
            return (T1 == other.T1 && T2 == other.T2 ||
                    T1 == other.T2 && T2 == other.T1);
        }

        public bool Contains(Team t) {
            return (T1 == t || T2 == t);
        }
    }
}
