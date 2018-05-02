using CsvHelper;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FORdeler
{
    class Loader
    {
        public List<Team> oldTeams;
        public List<Team> newTeams;

        public List<Member> members;

        public List<Member> loadMembers(string path, out List<Team> returnTeam)
        {
            string value;
            List<string> result = new List<string>();
            List<Member> members = new List<Member>();
            returnTeam = new List<Team>();

            using (TextReader fileReader = File.OpenText(path))
            {
                CsvReader csv = new CsvReader(fileReader);
                csv.Configuration.HasHeaderRecord = false;

                int rowCount = 0;
                while (csv.Read())
                {
                    // Reads and splits the CSV file into separate strings
                    csv.TryGetField<string>(0, out value);
                    List<string> row = value.Split(';', '\t', ',').ToList();
                    int numColumns = row.Count; //Counts number of entries in the row

                    for (int columnCount = 0; columnCount < numColumns; columnCount++)
                    {
                        // The first row is the name of the teams
                        if (rowCount == 0)
                        {
                            returnTeam.Add(new Team(row[columnCount]));
                        }
                        else if (row[columnCount].Count() > 0)
                        {
                            Member member = new Member(row[columnCount], returnTeam[columnCount]);
                            members.Add(member);
                            returnTeam[columnCount].Members.Add(member);
                        }
                    }
                    rowCount++;
                }
            }

            return members;
        }

        public void loadTwoBundles(string oldTeamPath, string newTeamPath)
        {
            List<Member> oldMembers = loadMembers(oldTeamPath, out oldTeams);
            members = loadMembers(newTeamPath, out newTeams);

            oldMembers.Sort();
            members.Sort();

            foreach (Member oldMember in oldMembers)
            {
                foreach (Member newMember in members)
                {
                    if (oldMember.Name == newMember.Name)
                    {
                        newMember.OldTeam = oldMember.BelongingTeam;
                    }
                }
            }
        }
    }
}
