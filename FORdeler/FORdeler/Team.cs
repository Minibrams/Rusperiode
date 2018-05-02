using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FORdeler
{
    class Team
    {
        public Team(string name)
        {
            Name = name;
        }

        public string Name;

        public List<Member> Members = new List<Member>();
    }
}
