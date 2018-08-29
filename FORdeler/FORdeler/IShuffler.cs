using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FORdeler
{
    interface IShuffler
    {
        List<Team> shuffle(List<Team> teams, List<TeamConstraint> teamSpecifications);
    }
}
