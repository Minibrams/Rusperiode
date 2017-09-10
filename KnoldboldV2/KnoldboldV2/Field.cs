using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KnoldboldV2
{
    class Field
    {
        public List<Tuple<Match, Match>> Rounds = new List<Tuple<Match, Match>>();
        public List<Field> AllFields; 
        public string Name;
        public Field(string name) {
            Name = name;
        }

        public override string ToString()
        {
            StringBuilder str = new StringBuilder();
            str.AppendLine(Name + ":");
            str.AppendLine();
            foreach (var round in Rounds) {
                int roundNum = Rounds.IndexOf(round);
                var m1 = round.Item1;
                var m2 = round.Item2;
                str.AppendLine($"Runde {roundNum + 1}: ");
                str.AppendLine($"{m1}      &&      {m2}");
                str.AppendLine($"       {m1.T1} skal til {NextField(m1.T1, roundNum)} næste gang");
                str.AppendLine($"       {m1.T2} skal til {NextField(m1.T2, roundNum)} næste gang");
                str.AppendLine($"       {m2.T1} skal til {NextField(m2.T1, roundNum)} næste gang");
                str.AppendLine($"       {m2.T2} skal til {NextField(m2.T2, roundNum)} næste gang");

                str.AppendLine();
            }

            str.AppendLine();
            return str.ToString();
        }

        private string NextField(Team t, int round) {
            try {
                foreach (var field in AllFields) {
                    if (field.Rounds[round + 1].Item1.Contains(t) ||
                        field.Rounds[round + 1].Item2.Contains(t)) {
                        return field.Name;
                    }
                }
            }
            catch (ArgumentOutOfRangeException e) {
                return "ingen steder, for der er ikke flere kampe";
            }
            
            return "KUNNE IKKE FINDE BANE";
        }
    }
}
