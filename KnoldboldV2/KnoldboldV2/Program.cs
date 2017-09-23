using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KnoldboldV2
{
    class Program
    {
        static List<Team> Teams = new List<Team>();
        static List<Field> Fields = new List<Field>();
        static List<Match> Matches = new List<Match>(); /* Just for doublechecking / debugging */

        static string extendedASCII = "iso-8859-1"; /* Extended ASCII that allows for special characters (æ, ø, å) */

        static void Main(string[] args) {
            Start();
        }

        public static void LoadTeams(string path) {
            try {
                string[] raw = File.ReadAllLines(path, Encoding.GetEncoding(extendedASCII));
                foreach (var line in raw) {
                    if (string.IsNullOrEmpty(line))
                        continue;
                    Teams.Add(new Team(line));
                }
            }
            catch (FileNotFoundException e) {
                UserPrompt($"Kunne ikke finde \"{e.FileName}\". Prøv igen...");
                InitTeams();
            }

            catch (Exception e) {
                UserPrompt("Et eller andet gik galt. Prøv igen... ");
                InitTeams();
            }
        }

        private static void Start() {
            InitTeams();
            InitFields();
            GenerateRounds();
            ExportGameplan();
        }
        public static void InitTeams() {
            UserPrompt("Indtast filnavn (uden .txt)");
            LoadTeams(Console.ReadLine() + ".txt");
            UserPrompt($"{Teams.Count} hold indlæst!");
        }

        private static void ExportGameplan() {
            UserPrompt("Spilplan klar! Tryk 'ENTER' for at eksportere spilplanen til \"Bane #.txt\"");
            while (Console.ReadKey().Key != ConsoleKey.Enter) { }
            Fields.ForEach(f => File.WriteAllText(
                Directory.GetCurrentDirectory() + $"\\{f.Name}.txt", 
                f.ToString()));
        }

        private static void UserPrompt(string prompt) {
            Console.WriteLine($"## {prompt}");
        }

        private static void InitFields() {
            int numFields = (Teams.Count + 3) / 4;
            UserPrompt($"Minimum antal baner: {numFields}");
            for (int i = 0; i < numFields; i++) {
                var f = new Field("Bane " + (i + 1));
                f.AllFields = Fields;
                Fields.Add(f);
            }
        }

        private static void GenerateRounds() {
            UserPrompt("Indtast antal runder");
            int numRounds = Int32.Parse(Console.ReadLine());
            UserPrompt($"12,5 minutter pr. runde = {numRounds * 12.5 / 60} timer");
            UserPrompt($"Genererer spilplan...");
            GamePlanner gp = new GamePlanner(Teams);

            for (int i = 0; i < numRounds; i++) {
                var matches = gp.GenerateRound();
                AssignMatchesToFields(matches);
            }
        }

        private static void AssignMatchesToFields(Stack<Match> matches) {
            foreach (var field in Fields) {
                if (matches.Count >= 2) {
                    var m1 = matches.Pop();
                    var m2 = matches.Pop();
                    Matches.Add(m1); Matches.Add(m2);
                    field.Rounds.Add(Tuple.Create(m1, m2));
                }
                else if (matches.Count == 1) {
                    var m1 = matches.Pop();
                    var m2 = new Match();
                    Matches.Add(m1); Matches.Add(m2);
                    field.Rounds.Add(Tuple.Create(m1, m2));
                }
                else {
                    var m1 = new Match();
                    var m2 = new Match();
                    Matches.Add(m1); Matches.Add(m2);
                    field.Rounds.Add(Tuple.Create(m1, m2));
                }
            }
        }

        private void DebugPrint() {

            foreach (var field in Fields) {
                Console.WriteLine(field);
            }

            /* Can only really happen when numRounds > numTeams */
            foreach (var first in Matches) {
                foreach (var second in Matches) {
                    if (first.Matches(second) && first != second) {
                        Console.WriteLine($"Ens kamp fundet: {first} og {second}");
                    }
                }
            }
        }
    }
}
