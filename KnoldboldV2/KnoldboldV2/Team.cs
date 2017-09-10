using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KnoldboldV2
{
    class Team
    {
        public string Name;
        public Team(string name) {
            Name = name;
        }

        public override string ToString() {
            return Name;
        }
    }
}
