import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class Xml_loader {
  BufferedReader br = null;
  FileReader fr = null;

  Xml_loader(String filename) {

    try {

      //br = new BufferedReader(new FileReader(FILENAME));
      fr = new FileReader(filename);
      br = new BufferedReader(fr);

      String sCurrentLine;

      while ((sCurrentLine = br.readLine()) != null) {
        System.out.println(sCurrentLine);
        if (sCurrentLine.startsWith("<Function")) {
          
        } else if (sCurrentLine.startsWith("<Function")) {
          
        } else if (sCurrentLine.startsWith("<DirectCall")) {
          
        } else if (sCurrentLine.startsWith("<Function")) {
          
        }
      }
    } 
    catch (IOException e) {

      e.printStackTrace();
    } finally {
      try {

        if (br != null)
          br.close();

        if (fr != null)
          fr.close();
      } 
      catch (IOException ex) {
        ex.printStackTrace();
      }
    }
  }
}
