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
            relation.NewTeam = belongingTeam;
            relation.correspondingMember = this;
        }

        public Relation relation;

        public string Name;

        public int CompareTo(Member obj)
        {
            return Name.CompareTo(obj.Name);
        }
    }
}
