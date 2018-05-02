using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FORdeler
{
    class Member : IComparable<Member>
    {
        public Member(string name, Team belongingTeam)
        {
            Name = name;
            BelongingTeam = belongingTeam;
        }

        public Team BelongingTeam;

        public Team OldTeam;

        public string Name;

        public int CompareTo(Member obj)
        {
            return Name.CompareTo(obj.Name);
        }
    }
}
