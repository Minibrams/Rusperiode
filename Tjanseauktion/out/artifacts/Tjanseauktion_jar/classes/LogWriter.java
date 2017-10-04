package Tjanseauktion;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

/**
 * Created by chrae on 31-08-2017.
 */
public class LogWriter {
    public void writeStatus(ArrayList<Auction> auctions, ArrayList<Team> teams){
        try {
            BufferedWriter logFile = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("log.txt"), StandardCharsets.UTF_8));

            for(Team t : teams){
                logFile.write(t.getLogOutput());
                logFile.newLine();
            }
            logFile.write("auctions");
            logFile.newLine();
            for(Auction a : auctions){
                logFile.write(a.getLogOutput());
                logFile.newLine();
            }
            logFile.close();
        } catch(Exception e){
            System.out.println("There was an error writing the log file");
        }
    }
}
