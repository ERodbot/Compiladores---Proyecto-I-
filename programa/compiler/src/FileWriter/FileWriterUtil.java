package FileWriter;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class FileWriterUtil {
   
    private static FileWriterUtil writter;
        
    private FileWriterUtil() {

    }

    public static synchronized FileWriterUtil getInstance() {
        if (writter==null) {
            writter = new FileWriterUtil();
        }
        return writter;
    }

    private static void writeTo(String fileName, String[] text){
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))){ 
            for(String line : text){
                writer.write(line);
                writer.newLine();
            }
            System.out.println("File written succesfully to: " + fileName);
        } catch(IOException e) {
            System.err.println("Error writting the file: " + e.getMessage());
        }
    }
    
}