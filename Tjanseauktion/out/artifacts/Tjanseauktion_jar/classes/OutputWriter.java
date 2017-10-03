package Tjanseauktion;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.FileOutputStream;
import java.util.ArrayList;

/**
 * Created by chrae on 02-09-2017.
 */
public class OutputWriter {
    private String filename;
    private Font titleFont = new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD);
    private Font teamHeadlineFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
    private Font infoFont = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL);
    private Document document;
    private ArrayList<Team> teams;

    public OutputWriter(String filename, ArrayList<Team> teams){
        this.filename = filename;
        this.teams = teams;
    }

    public void writeOutput(){
        try {
            document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, new FileOutputStream(filename));
            document.open();
            addContent();
            document.close();
        } catch (Exception e) {
            System.out.println("There was an error creating the output file");
            e.printStackTrace();

        }
    }

    private void addContent() throws DocumentException{
        Paragraph content = new Paragraph();
        // We add one empty line
        addEmptyLine(content, 1);
        // Lets write a big header
        content.add(new Paragraph("Resultat af tjanseauktion", titleFont));
        addEmptyLine(content, 1);
        for(Team t : teams){
            content.add(new Paragraph(t.getName(), teamHeadlineFont));
            for(String chore : t.getChores()){
                content.add(new Paragraph(chore, infoFont));
            }

            addEmptyLine(content, 1);
        }

        document.add(content);
    }

    private void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }
}
