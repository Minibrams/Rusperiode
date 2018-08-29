using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FORdeler
{
    class TeamConstraint
    {
        public TeamConstraint(string name)
        {
            team = new Team(name);
        }

        public Team team;

        public int maxMembers;
    }
}
